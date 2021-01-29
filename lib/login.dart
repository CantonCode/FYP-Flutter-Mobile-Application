import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp_application/auth_service.dart';
import 'package:fyp_application/home.dart';
import 'package:fyp_application/register.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String email = '';
  String password = '';
  String t = "";
  String t1 = "";

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.all(20),
      child: TextField(
        controller: emailController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Email",
        ),
      ),
    );
  }

  Widget _textFieldPass() {
    return Container(
      margin: EdgeInsets.all(20),
      child: TextField(
        controller: passController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Password",
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        try {
          context.read<AuthService>().signIn(
              email: emailController.text.trim(),
              password: passController.text.trim());
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } catch (e) {
          print(e.message);
        }
      }, // Handle your callback
      child: Container(
        width: 200,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _createAccount() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SubPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
              child: Column(children: <Widget>[
        Container(height: 120),
        Text("Please Enter Login Details"),
        _textFieldEmail(),
        _textFieldPass(),
        SizedBox(height: 20),
        _submitButton(),
        _createAccount()
      ]))),
    );
  }
}
