import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_realtime_detection/assesments.dart';
import 'package:flutter_realtime_detection/signuppage.dart';
import 'package:flutter_realtime_detection/userdashboard.dart';
import 'home.dart';
import 'hope/hope.dart';
import 'loginpage.dart';



List<CameraDescription> cameras;

Future<Null> main() async {
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.black,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),

        '/SignUp': (context) => SignupPage(),
        '/UserDashBoard': (context) => UserDashBoard(),
        '/Homepage':(context) => HomePage(cameras),
        '/Assesments':(context) => Assesments(),
        '/Hope':(context) => Hope(),
        },

    );
  }
}
