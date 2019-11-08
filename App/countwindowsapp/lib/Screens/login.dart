import 'package:flutter/material.dart';
import 'package:countwindowsapp/models/users/user_bloc_provider.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback login;

  const LoginPage({Key key, this.login}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController companyController = new TextEditingController();
  bool newUser = false;
  bool viewPassword = false;

  Color whiteTextColor = new Color(0xFFFFFFFF);
  Color greyTextColor = new Color.fromRGBO(102, 107, 121, 100);
  Color lightBlueButton = new Color(0xF521334D);
  Color backroundColor = new Color(0xF50B1F3D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                decoration: BoxDecoration(color: backroundColor),
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
                              color: newUser ? greyTextColor : whiteTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              letterSpacing: 1,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              newUser = false;
                            });
                          },
                          color: newUser ? null : lightBlueButton,
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
                                color: newUser ? whiteTextColor : greyTextColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                letterSpacing: 1),
                          ),
                          onPressed: () {
                            setState(() {
                              newUser = true;
                            });
                          },
                          color: newUser ? lightBlueButton : null,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Container(
                      height: 550,
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: newUser ? signupPage() : signinPage(),
                      ))
                ]))));
  }

  Widget signinPage() {
    TextEditingController companyText = new TextEditingController();
    TextEditingController passwordText = new TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 15.0),
          TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: companyText,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Company',
                icon: Icon(
                  Icons.mail,
                  color: Color(0xF88ACEA1),
                ),
                labelStyle: TextStyle(color: Colors.grey),
              )),
          SizedBox(height: 30.0),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              'View Password',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            padding: EdgeInsets.all(0),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: passwordText,
            obscureText: viewPassword ? false : true,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(Icons.remove_red_eye),
                color: viewPassword ? Color(0xF88ACEA1) : Colors.red,
                onPressed: () {
                  if (viewPassword) {
                    setState(() {
                      viewPassword = false;
                    });
                  } else {
                    setState(() {
                      viewPassword = true;
                    });
                  }
                },
              ),
              icon: Icon(Icons.lock, color: Color(0xF88ACEA1)),
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 30.0),
          FlatButton(
            child: Text(
              'FORGOT PASSWORD?',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xF88ACEA1),
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  letterSpacing: 2),
            ),
            onPressed: () {},
          ),
          SizedBox(height: 50.0),
          Container(
            child: FlatButton(
              child: Text(
                'SIGN IN',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1),
              ),
              onPressed: () {
                if (companyText.text != null || passwordText.text != null) {
                  userBloc
                      .signinUser(companyText.text, passwordText.text, "")
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
    );
  }

  Widget signupPage() {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 15.0),
          TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your Email';
                }
                return null;
              },
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                icon: Icon(
                  Icons.mail,
                  color: Color(0xF88ACEA1),
                ),
                labelStyle: TextStyle(color: Colors.grey),
              )),
          SizedBox(height: 15.0),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your Password';
              }
              return null;
            },
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              icon: Icon(Icons.lock, color: Color(0xF88ACEA1)),
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 15.0),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Confirm your Password';
              }
              return null;
            },
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              icon: Icon(Icons.lock, color: Color(0xF88ACEA1)),
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 15.0),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Company name';
              }
              return null;
            },
            controller: companyController,
            decoration: InputDecoration(
              labelText: 'Company',
              icon: Icon(Icons.business, color: Color(0xF88ACEA1)),
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 50.0),
          Container(
            child: FlatButton(
              child: Text(
                'SIGN UP',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  if (passwordController != null) {
                    if (passwordController.text ==
                        confirmPasswordController.text) {
                      if (emailController.text != null ||
                          companyController != null) {
                        userBloc
                            .registerUser(
                          companyController.text,
                          emailController.text,
                          passwordController.text,
                        )
                            .then((_) {
                          widget.login();
                        });
                      }
                    } else {
                      
                    }
                  } else {

                  }
                }
              },
              color: Color(0xF88ACEA1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
            ),
          )
        ],
      ),
    );
  }
}
