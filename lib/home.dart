import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fyp_application/auth_service.dart';

import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home",
      home: Scaffold(
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController _animationController;
  AnimationController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  void _handleOnPressed() {
    _changeOpacity();
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          // ignore: unnecessary_statements
          ? _animationController.forward()
          : _animationController.reverse();

      isPlaying ? _controller.forward() : _controller.reverse();
    });
  }

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

  Widget _startSession() {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xfffbb448), Color(0xfff7892b)])),
      child: IconButton(
        iconSize: 150,
        splashColor: Colors.greenAccent,
        icon: AnimatedIcon(
          color: Colors.white,
          icon: AnimatedIcons.pause_play,
          progress: _animationController,
        ),
        onPressed: () => _handleOnPressed(),
      ),
    );
  }

  Widget _session() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
        width: w - 45,
        height: 400,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.deepOrange, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            Align(
                alignment: Alignment.center,
                child: Text("Session Started",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 40)))
          ],
        ));
  }

  double opacityLevel = 1.0;
  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  Widget _sceneStart() {
    Animation aanimation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);
    return Stack(
      children: <Widget>[
        RotationTransition(turns: _animationController,
        child:FadeTransition(
            opacity: _animationController,
            child: Container(
              key: ValueKey(0),
              alignment: Alignment.center,
              child: Image.asset("image/skate1.png",
                  height: 325, width: 300, fit: BoxFit.fitHeight),
            ))),
        FadeTransition(
            opacity: aanimation,
            child: Container(
              alignment: Alignment.center,
              child: _session(),
            )),
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
              _sceneStart(),

              FadeTransition(
                  opacity: _animationController,
                  child: Container(
                      key: ValueKey(0),
                      alignment: Alignment.center,
                      child: Text("Start Session",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 40)))),

              Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: _startSession())),

              // ClipOval(
              //     child: Container(
              //   width: 100,
              //   height: 100,
              //   child: Icon(
              //     Icons.play_arrow_outlined,
              //     size: 40,
              //   ),
              //   decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //           begin: Alignment.centerLeft,
              //           end: Alignment.centerRight,
              //           colors: [Color(0xfffbb448), Color(0xfff7892b)])),
              // )),
              // Expanded(
              //     child: Align(
              //         alignment: Alignment.bottomCenter,
              //         child: RaisedButton(
              //           onPressed: () {},
              //           child: Text("Connect Device"),
              //         ))),
              // SizedBox(height: 20),
            ])))));
  }
}
