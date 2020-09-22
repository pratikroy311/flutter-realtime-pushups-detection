

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class SignupPage extends StatefulWidget {
  @override
  State createState() => new SignupPageState();
}

class SignupPageState extends State<SignupPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;


  final _auth = FirebaseAuth.instance;
  bool showspinner =false;
  String name;
  String email;
  String pno;
  String password;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }
  
  void _showToast(){
    Fluttertoast.showToast(
      msg: "Successfully logged in",

    );
  }
  void _sameId(){
    Fluttertoast.showToast(
      msg: "Email already exists",

    );
  }



  

  @override
  Widget build(BuildContext context) {

    return ModalProgressHUD(
      inAsyncCall: showspinner,
      color: Colors.yellowAccent,
      child: new Scaffold(
        //resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Container(

          child: new Stack(fit: StackFit.expand, children: <Widget>[
            new Theme(
              data: new ThemeData(
                  accentColor: Colors.lightBlue,
                  inputDecorationTheme: new InputDecorationTheme(
                    labelStyle:
                    new TextStyle(color: Colors.black, fontSize: 23.0),
                  )),
              isMaterialAppTheme: true,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Hero(
                      tag: "hero",
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        backgroundImage: AssetImage("assets/images/logo1.jpg"),
                        radius:  40.0,
                      ),
                    ),
                  ),
                  Text("Health Is Wealth",style: new TextStyle(
                    fontSize: 30.0,color: Colors.blueGrey,

                  ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      elevation: 2.0,
                      color: Colors.blueGrey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: new Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            autovalidate: true,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  TextField(
                                    textAlign:TextAlign.center,
                                    onChanged: (value){
                                      name = value;
                                    },
                                    decoration: InputDecoration(

                                      hintText: "Enter Name",fillColor: Colors.deepOrange,
                                      icon: Icon(Icons.text_format),
                                    ),
                                    keyboardType: TextInputType.text,
                                  ),
                                  TextField(
                                    keyboardType:TextInputType.emailAddress,
                                    textAlign:TextAlign.center,
                                    onChanged: (value){
                                        email = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter Email",fillColor: Colors.deepOrangeAccent,
                                      icon: Icon(Icons.email),
                                    ),

                                  ),
                                  TextField(
                                    textAlign:TextAlign.center,
                                    onChanged: (value){
                                      password = value;

                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter New Password",fillColor: Colors.deepOrange,
                                      icon: Icon(Icons.lock),

                                    ),
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                  ),
                                  TextField(
                                    keyboardType:TextInputType.phone,
                                    textAlign:TextAlign.center,
                                    onChanged: (value){
                                      pno = value;
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Enter Phone no.",fillColor: Colors.deepOrange,
                                      icon: Icon(Icons.phone),

                                    ),

                                    obscureText: true,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(top: 40.0)
                                  ),
                                  Center(
                                    child: MaterialButton(
                                        height: 45.0,
                                        minWidth: 250.0,
                                        color: Colors.tealAccent,
                                        textColor: Colors.black,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                                        child: new Text(
                                          "SignUp",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        onPressed: () async{
                                          try {
                                        final _newuser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                                          _showToast;
                                          if(_newuser != null)
                                          {
                                            Navigator.pushNamed(context, '/UserDashBoard');
                                          }
                                          }
                                          catch (e){
                                            _sameId();}
                                          }
                                          ),
                                          ),
                                          Padding(
                                          padding:
                                         EdgeInsets.only(top: 10.0)
                                  ),
                                  Center(child: new Text("have an account?")),
                                  Center(
                                    child: MaterialButton(
                                        height: 45.0,
                                        minWidth: 250.0,
                                        color: Colors.teal,
                                        textColor: Colors.black,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                                        child: new Text(
                                          "LogIn",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        onPressed: () {

                                          Navigator.pushNamed(context, '/');
                                        }
                                    ),
                                  )
                                ]
                            ),
                          )
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
