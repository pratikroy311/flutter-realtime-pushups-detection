import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserDashBoard extends StatefulWidget {
  @override
  _UserDashBoardState createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String useremail;


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
      getNavItem(Icons.assessment, "Assesment", "/Assesments"),
      getNavItem(Icons.assistant, "Life", "/Hope"),
      aboutChild
    ];

    ListView listView = ListView(children: myNavChildren);

    return Drawer(
      child: listView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfbab66),
      appBar: new AppBar(
        backgroundColor: Colors.blue,
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
      body: Container(
        color: Colors.white,
          child: Center(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: MaterialButton(
                    onPressed: (){
                      Navigator.pushNamed(
                          context, '/Homepage');
                    },
                    child: new Card(
                      color: Colors.white70,
                      elevation: 30.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      
                      child: Container(
                        height: 150.0,
                        decoration: BoxDecoration(
                           image: DecorationImage(
                             fit: BoxFit.fill,
                             image: AssetImage("assets/images/2.jpeg")
                           )
                        ),

                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10.0),),
                MaterialButton(
                  onPressed: (){
                    Navigator.pushNamed(
                        context, '/Assesments');
                  },
                  child: Container(
                    child: Card(
                      color: Colors.white70,
                      elevation: 15.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: new Container(
                        height: 150.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("assets/images/9.jpeg")
                            )
                        ),

                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10.0),),
                MaterialButton(
                  onPressed: (){
                    Navigator.pushNamed(
                        context, '/Hope');
                  },
                  child: Container(
                    height: 150.0,
                    decoration: BoxDecoration(

                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/7.jpeg"),
                      ),
                    ),
                    child: Card(
                      color: Colors.transparent,

                      elevation: 15.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: new Container(

                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          )),
      drawer: getNavDrawer(context),
    );
  }
}