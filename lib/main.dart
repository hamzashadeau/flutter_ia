import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:object_detection/realtime/cnn.dart';
import 'package:object_detection/realtime/live_camera.dart';
import 'package:object_detection/static%20image/static.dart';
List<CameraDescription> cameras;

Future<void> main() async {
  // initialize the cameras when the app starts
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  // running the app
  runApp(
    MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    )
  );
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Welcome to Object Detector App"),
        backgroundColor:Colors.deepPurpleAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: aboutDialog,
          ),
        ],
      ),
      body: Container(
        decoration: new BoxDecoration(
            color: Colors.lightBlueAccent
        ),
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Column(
          children: [
              Image.asset('assets/image.png',width: 250,height: 200),
              ],),
              ButtonTheme(
                buttonColor: Colors.deepPurple,     //  <-- dark color
                textTheme: ButtonTextTheme.primary,
                minWidth: 100,
                child: RaisedButton(
                  child: Text("yolov"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Cnn(cameras),
                      ),
                    );
                  },
                ),
              ),
              ButtonTheme(
                buttonColor: Colors.yellow,         //  <-- light color
                textTheme: ButtonTextTheme.primary,
                minWidth: 100,
                child: RaisedButton(
                  child: Text("SSD"),
                  onPressed:() {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LiveFeed(cameras),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child:Container(
          color: Colors.greenAccent,
          height: 60.0,
          child: Row(
            children: <Widget>[
              Text("SDAD-2020 **********  By Bouigrouane & Ameur"),
            ],
          ),
        )
      ),
    );
  }

  aboutDialog(){
     showAboutDialog(
      context: context,
      applicationName: "Object Detector App",
      applicationLegalese: "By Bouigrouane & Ameur",
      applicationVersion: "1.0",
      children: <Widget>[
        Text("www.fstg.ma"),
      ],
    );
  }

}