import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fyp_application/auth_service.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "REGISTER",
      home: Scaffold(
        appBar: AppBar(),
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return MaterialApp(
        home: Scaffold(
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text("Ashish Rawat"),
                    accountEmail: Text(firebaseUser.email),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).platform == TargetPlatform.iOS
                              ? Colors.blue
                              : Colors.white,
                      child: Text(
                        "A",
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                  ListTile(
                      title: Text("Previous Sessions"),
                      trailing: Icon(Icons.arrow_back_rounded)),
                  ListTile(
                    title: Text("User Settings"),
                    trailing: Icon(Icons.supervised_user_circle_sharp),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Sign Out"),
                    trailing: Icon(Icons.exit_to_app_sharp),
                    onTap: () {
                      context.read<AuthService>().signOut();
                    },
                  ),
                ],
              ),
            ),
            body: Center(
                child: Container(
                    child: Column(children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Text("HOME PAGE"),
              SizedBox(
                height: 16,
              ),
              Text("WELCOME: " + firebaseUser.email.toString()),
              SizedBox(
                height: 16,
              ),
              new Image.asset('images/skater2.png', width: 100.0, height: 100.0),
              ClipOval(
                  child: Container(
                width: 100,
                height: 100,
                child: Icon(Icons.play_arrow_outlined,size: 40,) ,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xfffbb448), Color(0xfff7892b)])),

              )),
              RaisedButton(
                onPressed: () {},
                child: Text("Connect Device"),
              ),
            ])))));
  }
}
