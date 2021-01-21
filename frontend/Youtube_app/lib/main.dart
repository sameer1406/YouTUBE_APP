import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:http/http.dart' as http;
import 'package:Youtube_app/urlModel.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:permission_handler/permission_handler.dart';

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
    // data = json.decode(response.body);
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
  String title;
  int views;
  var thumbnail;
  var dirpath;
  bool _loading = false;
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

              RaisedButton(
                onPressed: () async {
                  final PermissionHandler _permissionHandler =
                      PermissionHandler();
                  var result = await _permissionHandler
                      .requestPermissions([PermissionGroup.storage]);

                  // var dir = await
                  if (_formkey.currentState.validate()) {
                    if (result[PermissionGroup.storage] ==
                        PermissionStatus.granted) {
                      var dirpath =
                          await ExtStorage.getExternalStoragePublicDirectory(
                              ExtStorage.DIRECTORY_DOWNLOADS);

                      final UrlModel = await passInfo(urlTextController.text);
                      // _loading ? LinearProgressIndicator() : _urlModel;

                      setState(() {
                        _loading = !_loading;
                        _urlModel = UrlModel;
                        views = _urlModel.views;
                        title = _urlModel.title;
                        thumbnail = _urlModel.thumbnail;
                      });
                      print(dirpath);
                    }
                    // print(title);
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
              ),

              title != null
                  ? Column(children: <Widget>[Text("Title:" "${title}")])
                  : Container(),
              views != null
                  ? Column(children: <Widget>[Text("Views:" "${views}")])
                  : Container(),
              thumbnail != null
                  ? Container(child: Image.network("${thumbnail}"))
                  : Container(),
              // title != null
              //     ? ElevatedButton(
              //         onPressed: null,
              //         child: Text('Download'),
              //       )
              //     : Container()
            ],
          ),
        ),
      ),
    );
  }
}
