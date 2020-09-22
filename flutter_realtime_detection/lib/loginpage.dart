
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;
  final auth = FirebaseAuth.instance;
  bool showspinner =false;
  String email;
  String password;



  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 400));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceIn,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }




  void _showToast(){
    Fluttertoast.showToast(
      msg: "Successfully logged in",

    );
  }
  void _wrongid(){
    Fluttertoast.showToast(
      msg: "wrong email or password!",

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
          backgroundColor: Colors.lightBlue,
          body: Container(
            child: new Stack(fit: StackFit.expand, children: <Widget>[

              new Theme(
                data: new ThemeData(
                    accentColor: Colors.lightBlue,
                    inputDecorationTheme: new InputDecorationTheme(
                      labelStyle:
                      new TextStyle(color: Colors.blueGrey, fontSize: 23.0),
                    )),
                isMaterialAppTheme: true,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[

                    Hero(
                      tag: 'hero',
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        backgroundImage: AssetImage("assets/images/logo1.jpg"),
                        radius: _iconAnimation.value * 60.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text("Health Is Wealth", style: new TextStyle(
                        fontSize: 30.0,

                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        elevation: 2.0,
                        color: Colors.white70,
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
                                    Container(

                                        child: TextField(
                                          keyboardType: TextInputType.emailAddress,
                                          onChanged: (value) {
                                            email = value;
                                          },
                                          textAlign: TextAlign.center,

                                          decoration: InputDecoration(
                                            labelText: "Enter Email",
                                            fillColor: Colors.deepOrange,
                                            icon: Icon(Icons.person),
                                          ),
                                        ),
                                      ),
                                    TextField(
                                      textAlign: TextAlign.center,
                                      onChanged: (value) {
                                        password = value;
                                      },
                                      decoration: InputDecoration(
                                        labelText: "Enter Password",
                                        fillColor: Colors.deepOrange,
                                        icon: Icon(Icons.lock),

                                      ),
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 40.0)
                                    ),
                                    Center(
                                      child: MaterialButton(
                                        height: 45.0,
                                        minWidth: 250.0,
                                        color: Colors.lightBlue[700],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),),
                                        textColor: Colors.black,
                                        child: new Text(
                                          "LogIn",
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                        onPressed: () async {
                                          setState(() {

                                          });
                                          try {
                                            final user = await auth.signInWithEmailAndPassword(
                                                email: email, password: password);
                                            _showToast();
                                            if (user != null) {
                                              showspinner =true;
                                              Navigator.pushNamed(
                                                  context, '/UserDashBoard');
                                            }
                                            setState((){
                                              showspinner =false;
                                            });
                                          }
                                          catch (e) {
                                            _wrongid();

                                          }
                                        },

                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                    ),
                                    Center(
                                      child: MaterialButton(
                                          height: 45.0,
                                          minWidth: 250.0,
                                          color: Colors.teal,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.0),),
                                          textColor: Colors.black,
                                          child: new Text(
                                            "SignUp",
                                            style: TextStyle(
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState((){
                                              showspinner =true;
                                            });
                                            Navigator.pushNamed(context, '/SignUp');
                                            setState((){
                                              showspinner =false;
                                            });
                                          }
                                      ),
                                    ),


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