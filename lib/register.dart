import 'package:email_validator/email_validator.dart';
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
  String _username, _email, _password = "";
  final _formKey = GlobalKey<FormState>();

  Widget EmailInput() {
    return Container(
        margin: EdgeInsets.all(20),
        child: TextFormField(
          // focusNode: _emailFocusNode,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Email",
            hintText: "e.g abc@gmail.com",
            suffixIcon: Icon(Icons.email_outlined),
          ),
          textInputAction: TextInputAction.next,
          controller: emailController,
          validator: (email) =>
              EmailValidator.validate(email) ? null : "Invalid email address",
          onSaved: (email) => _email = email,
          // onFieldSubmitted: (_){
          //   fieldFocusChange(context, _emailFocusNode, _passwordFocusNode);
          // },
        ));
  }

  Widget NameInput() {
    return Container(
        margin: EdgeInsets.all(20),
        child: TextFormField(
          // focusNode: _usernameFocusNode,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Username",
            hintText: "e.g Morgan123",
            suffixIcon: Icon(Icons.supervised_user_circle_outlined),
          ),
          textInputAction: TextInputAction.next,
          validator: (name) {
            Pattern pattern = r'^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(name))
              return 'Invalid username';
            else
              return null;
          },
          onSaved: (name) => _username = name,
          // onFieldSubmitted: (_){
          //   fieldFocusChange(context, _usernameFocusNode, _emailFocusNode);
          // },
        ));
  }

  Widget PasswordInput() {
    return Container(
        margin: EdgeInsets.all(20),
        child: TextFormField(
      // focusNode: _passwordFocusNode,
      keyboardType: TextInputType.text ,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Password",
        suffixIcon: Icon(Icons.lock_outline),
      ),
      textInputAction: TextInputAction.done,

      validator: (password){
        Pattern pattern =
            r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
        RegExp regex = new RegExp(pattern);
        if (!regex.hasMatch(password))
          return 'Invalid password';
        else
          return null;
      },
      onSaved: (password)=> _password = password,
    ));
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
              NameInput(),
              EmailInput(),
              PasswordInput(),
              _submitButton(),
              _loginAccountLabel()
            ]));
  }
}
