import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:http/http.dart' as http;
import 'package:Youtube_app/urlModel.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Download Videos from YouTube'),
    );
  }
}

Future<UrlModel> passInfo(String url) async {
  final String apiurl = "http://10.0.2.2:5000/Youtube";
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };
  final response = await http.post(apiurl,
      headers: headers, body: json.encode({"link": url}));
  if (response.statusCode == 200) {
    final String responsestring = response.body;
    return urlModelFromJson(responsestring);
  } else {
    return null;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: new SecondScreen(),
      title: new Text(
        'Download Videos',
        textScaleFactor: 2,
      ),
      image: new Image.network(
          'https://www.lifewire.com/thmb/uevGm8GmYjR8UwXH0pkAl4xmexM=/960x640/filters:no_upscale():max_bytes(150000):strip_icc()/download-7105085d68424c93a47bcc6228d946fa.png'),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  UrlModel _urlModel;
  final _formkey = GlobalKey<FormState>();
  TextEditingController urlTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
        appBar: AppBar(title: Text("Download Videos")),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Paste The Url',
                    labelText: 'Enter Your Url',
                    prefixIcon: Icon(Icons.music_video)),
                controller: urlTextController,
                validator: (text) {
                  if (text.isEmpty) {
                    return 'Paste Url of the video';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    // _formkey.currentState.save();
                    final UrlModel = await passInfo(urlTextController.text);
                    setState(() {
                      _urlModel = UrlModel;
                    });
                    Fluttertoast.showToast(
                        msg: "${_urlModel.title}",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Error",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1);
                  }
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
