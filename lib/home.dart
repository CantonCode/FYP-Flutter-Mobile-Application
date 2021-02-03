import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fyp_application/auth_service.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _drawer() {
    final firebaseUser = context.watch<User>();
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Ashish Rawat"),
            accountEmail: Text(firebaseUser.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
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
    );
  }

  Widget _topBar() {
    return Row(
      children: [
    Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
            color: Colors.orangeAccent,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    final firebaseUser = context.watch<User>();
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return MaterialApp(
        home: Scaffold(
            key: _scaffoldKey,
            drawer: _drawer(),
            body: Center(
                child: Container(
                    child: Column(children: <Widget>[
              SizedBox(
                height: h * 0.1,
              ),
              _topBar(),
              
              ClipOval(
                  child: Container(
                width: 100,
                height: 100,
                child: Icon(
                  Icons.play_arrow_outlined,
                  size: 40,
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xfffbb448), Color(0xfff7892b)])),
              )),
              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text("Connect Device"),
                      ))),
              SizedBox(height: 20),
            ])))));
  }
}
