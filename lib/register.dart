import 'package:flutter/material.dart';

import 'login.dart';

class SubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "REGISTER",
      home: Scaffold(
        appBar: AppBar(
          title: Text("REGISTER"),
        ),
        body: RegisterScreen(),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Widget _entryField(String title, TextEditingController data,
      {bool isPassword = false}) {
    return Container(
        margin: EdgeInsets.all(20),
        child: TextFormField(
            controller: data,
            validator: (value) {
              if (value.isEmpty) {
                return "Please enter " + title;
              }
              return null;
            },
            obscureText: isPassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: title,
            )));
  }

  Widget _submitButton() {
    return InkWell(
        onTap: () {
          if (_formKey.currentState.validate()) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Processing Data')));
          }
        }, // Handle your callback
        child: Container(
          width: 200,
          padding: EdgeInsets.symmetric(vertical: 15),
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
            'Register Now',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
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
    // return MaterialApp(
    //     home: Scaffold(
    //         body: Center(
    //             child: Form(
    //                 key: _formKey,
    //                 child: Column(children: <Widget>[
    //                   Container(height: 120),
    //                   Text("Please Enter Register Details"),
    //                   _entryField("Username", userNameController),
    //                   _entryField("Email", emailController),
    //                   _entryField("Password", passController, isPassword: true),
    //                   _submitButton(),
    //                   _loginAccountLabel()
    //                 ])))));

    return Form(
        key: _formKey,
        child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Please Enter Register Details"),
              _entryField("Username", userNameController),
              _entryField("Email", emailController),
              _entryField("Password", passController, isPassword: true),
              _submitButton(),
              _loginAccountLabel()
            ]));
  }
}
