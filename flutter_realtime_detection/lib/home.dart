import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'package:firebase_auth/firebase_auth.dart';

import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomePage(this.cameras);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  @override


  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();

  }

  void getCurrentUser() async {
    try{
      final user = await _auth.currentUser();
      if(user != null)
      {
        loggedInUser =user;
        print(loggedInUser.email);
      }}
    catch(e){
      print(e);
    }


  }
  loadModel() async {
    String res;
    switch (_model) {

      case posenet:
        res = await Tflite.loadModel(
            model: "assets/yolov2_tiny.tflite");
        break;

      default:
        res = await Tflite.loadModel(
            model: "assets/ssd_mobilenet.tflite",
            labels: "assets/ssd_mobilenet.txt");
    }
    print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  Drawer getNavDrawer(BuildContext context) {
    var userinfo = Center(
      child: UserAccountsDrawerHeader(
        accountName: Text("Test"),
        accountEmail: Text("test@gmail.com"),
        currentAccountPicture: CircleAvatar(
          backgroundColor:
          Theme.of(context).platform == TargetPlatform.iOS
              ? Colors.blue
              : Colors.white,
          child: Text(
            "T",
            style: TextStyle(fontSize: 40.0),
          ),
        ),
      ),
    );

    var aboutChild = AboutListTile(
        child: Text("About"),
        applicationName: "Medico",
        applicationVersion: "v1.0.0",
        applicationIcon: Icon(Icons.adb),
        icon: Icon(Icons.info));

    ListTile getNavItem(var icon, String s, String routeName) {
      return ListTile(
        leading: Icon(icon),
        title: Text(s),
        onTap: () {
          setState(() {
            // pop closes the drawer
            Navigator.of(context).pop();
            // navigate to the route
            Navigator.of(context).pushNamed(routeName);
          });
        },
      );
    }

    var myNavChildren = [
      userinfo,
      //headerChild,
      //getNavItem(Icons.accessibility, "Posenet",'/'),
      getNavItem(Icons.home, "Home", "/UserDashBoard"),
      getNavItem(Icons.accessibility, "Posture detect", "/Homepage"),
      getNavItem(Icons.assessment, "Assesment", "/Homepage"),
      getNavItem(Icons.assistant, "voice assistant", "/Homepage"),
      aboutChild
    ];

    ListView listView = ListView(children: myNavChildren);

    return Drawer(
      child: listView,
    );
  }


  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: new AppBar(
        backgroundColor: Color(0xFFf7418c),
        actions: <Widget>[
          IconButton( icon: Icon(Icons.exit_to_app),
              tooltip: "LogOut",
              onPressed: (){
                _auth.signOut();
                Navigator.pop(context);
              }
          ),
        ],
      ),
      drawer: getNavDrawer(context),
      body: Stack(
        children: <Widget>[
          _model == ""
              ? Center(
            child: Card(
              color: Colors.white70,
              elevation: 15.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: MaterialButton(
                  height: 45.0,
                  minWidth: 250.0,
                  child: const Text("POSENET",style: TextStyle(fontSize: 20.0,color: Colors.redAccent,fontWeight: FontWeight.bold),),
                  onPressed: () => onSelect(posenet),
                ),
              ),
            ),)
              : Stack(
            children: [
              Camera(
                widget.cameras,
                _model,
                setRecognitions,
              ),
              BndBox(
                  _recognitions == null ? [] : _recognitions,
                  math.max(_imageHeight, _imageWidth),
                  math.min(_imageHeight, _imageWidth),
                  screen.height,
                  screen.width,
                  _model),
            ],
          ),
        ],
      ),

    );
  }
}