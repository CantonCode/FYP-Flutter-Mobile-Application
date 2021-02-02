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
                    accountEmail: Text("ashishrawat2911@gmail.com"),
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
                    title: Text("Ttem 1"),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                  ListTile(
                    title: Text("Item 2"),
                    trailing: Icon(Icons.arrow_forward),
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
              RaisedButton(
                onPressed: () {
                  context.read<AuthService>().signOut();
                },
                child: Text("Sign Out"),
              )
            ])))));
  }
}
