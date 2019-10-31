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
        body: Center(
      child: widget.newUser ? signupPage() : signinPage(),
    ));
  }

  Widget signinPage() {
    TextEditingController usernameText = new TextEditingController();
    TextEditingController passwordText = new TextEditingController();

    return Container(
        decoration: BoxDecoration(color: Color(0xF50B1F3D)),
        padding: EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          SizedBox(height: 60.0),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: 100,
                width: 130,
                child: FlatButton(
                  child: Text(
                    'LOGIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        letterSpacing: 1,)
                        ,
                  ),
                  onPressed: () {},
                  color: Color(0xF521334D),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                ),
              ),
              Container(
                height: 100,
                width: 130,
                child: FlatButton(
                  child: Text(
                    'REGISTER',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(102, 107, 121, 100),
                        fontWeight: FontWeight.w600,
                        fontSize: 20, letterSpacing: 1),
                  ),
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.0),
          Container(
            height: 400,
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white,),
            child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    TextFormField(
                        controller: usernameText,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          icon: Icon(
                            Icons.mail,
                            color: Color(0xF88ACEA1),
                          ),
                          labelStyle: TextStyle(color: Colors.grey),
                        )),
                    SizedBox(height: 30.0),
                    TextFormField(
                      controller: passwordText,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.lock, color: Color(0xF88ACEA1)),
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    FlatButton(child: Text('FORGOT PASSWORD?',  textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0xF88ACEA1),
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        letterSpacing: 2
                        ),
                  ),
                  onPressed: () {},),
                  SizedBox(height: 50.0),
                  Container(
                    child: FlatButton(
                  child: Text(
                    'LOGIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20, letterSpacing: 1),
                  ),
                  onPressed: () {
                    if (usernameText.text != null || passwordText.text != null) {
                  userBloc
                      .signinUser(usernameText.text, passwordText.text, "")
                      .then((_) {
                    widget.login();
                  });
                }
                  },
                  color: Color(0xF88ACEA1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0)),
                ),
                
                  )
                  ],
                ),
              ),
            
          ),
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
