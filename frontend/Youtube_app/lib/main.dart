import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

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

// class SecondScreen extends StatelessWidget {
//   final _formkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("Download Videos")),
//         body: Container(
//           child: Text("homepage"),
//         ));
//   }
// }
class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(title: Text("Download Videos")),
    //     body: Container(
    //       child: Text("homepage"),
    //     ));
    return Form(
      child: Scaffold(
        key: _formkey,
        appBar: AppBar(title: Text("Download Videos")),
        body: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Enter your username'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
