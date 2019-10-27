import 'package:flutter/material.dart';
import 'package:countwindowsapp/models/users/user_bloc_provider.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback login;
  final bool newUser;

  const LoginPage({Key key, this.login, this.newUser}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Page Flutter Firebase"),
        ),
        body: Center(
          child: widget.newUser ? signupPage() : signinPage(),
        ));
  }

  Widget signinPage() {
    TextEditingController usernameText = new TextEditingController();
    TextEditingController passwordText = new TextEditingController();

    return Container(
        padding: EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          SizedBox(height: 20.0),
          Text(
            'Login information',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: usernameText,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextFormField(
            controller: passwordText,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          SizedBox(height: 20.0),
          RaisedButton(
              child: Text('LOGIN'),
              onPressed: () {
                if (usernameText.text != null || passwordText.text != null) {
                  userBloc
                      .signinUser(usernameText.text, passwordText.text, "")
                      .then((_) {
                    widget.login();
                  });
                }
              }),
          Container(
              child: Column(
            children: <Widget>[
              Text(
                "Don't you even have an account yet?!",
                textAlign: TextAlign.center,
              ),
              FlatButton(
                child: Text(
                  "create one",
                ),
                onPressed: () {
                  signupPage();
                },
              )
            ],
          ))
        ]));
  }

  Widget signupPage() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: "Email"),
          ),
          TextField(
            controller: usernameController,
            decoration: InputDecoration(hintText: "Username"),
          ),
          TextField(
            controller: firstNameController,
            decoration: InputDecoration(hintText: "First name"),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(hintText: "Password"),
          ),
          FlatButton(
            color: Colors.green,
            child: Text("Sign up"),
            onPressed: () {
              if (usernameController.text != null ||
                  passwordController.text != null ||
                  emailController.text != null) {
                userBloc
                    .registerUser(
                        usernameController.text,
                        firstNameController.text ?? "",
                        "",
                        passwordController.text,
                        emailController.text)
                    .then((_) {
                  widget.login();
                });
              }
            },
          )
        ],
      ),
    );
  }
}
