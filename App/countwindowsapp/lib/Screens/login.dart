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

  String _company;
  String _email;

  bool newUser = false;
  bool viewPassword = false;
  bool _autoValidate = false;

  Color whiteTextColor = new Color(0xFFFFFFFF);
  Color greyTextColor = new Color.fromRGBO(102, 107, 121, 100);
  Color lightBlueButton = new Color(0xF521334D);
  Color backroundColor = new Color(0xF50B1F3D);

  TextEditingController companyText = new TextEditingController();
  TextEditingController passwordText = new TextEditingController();

  @override
  void dispose() {
    companyText.dispose();
    passwordText.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      viewPassword = !viewPassword;
    });
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  Widget _onPressedRegister(BuildContext context) {
    return FlatButton(
      child: Text(
        'REGISTER',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: whiteTextColor,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    );
  }

  Widget _notPressedRegister(BuildContext context) {
    return OutlineButton(
      child: Text(
        'REGISTER',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: greyTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 1),
      ),
      onPressed: () {
        setState(() {
          newUser = true;
        });
      },
      color: lightBlueButton,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      borderSide: BorderSide(
        color: greyTextColor,
      ),
    );
  }

  Widget _notPressedLogin(BuildContext context) {
    return OutlineButton(
      child: Text(
        'LOGIN',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: greyTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 1),
      ),
      onPressed: () {
        setState(() {
          newUser = false;
        });
      },
      color: newUser ? lightBlueButton : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      borderSide: BorderSide(
        color: greyTextColor,
      ),
    );
  }

  Widget _onPressedLogin(BuildContext context) {
    return FlatButton(
      child: Text(
        'LOGIN',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: whiteTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 1),
      ),
      onPressed: () {
        setState(() {
          newUser = false;
        });
      },
      color: lightBlueButton,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    );
  }

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
                        child: newUser
                            ? _notPressedLogin(context)
                            : _onPressedLogin(context),
                      ),
                      Container(
                        height: 100,
                        width: 130,
                        child: newUser
                            ? _onPressedRegister(context)
                            : _notPressedRegister(context),
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
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
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
              onSaved: (val) {
                _company = val;
              },
              controller: companyText,
              decoration: InputDecoration(
                labelText: 'Company',
                icon: Icon(
                  Icons.business,
                  color: Color(0xF88ACEA1),
                ),
                labelStyle: TextStyle(color: Colors.grey),
              )),
          SizedBox(height: 30.0),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: passwordText,
            obscureText: viewPassword,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: viewPassword
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                color: viewPassword ? Colors.red : Color(0xF88ACEA1),
                onPressed: _toggleVisibility,
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
                'LOGIN',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  userBloc
                      .signinUser(
                          companyText.text.toUpperCase(), passwordText.text, "")
                      .then((_) {
                    widget.login();
                  });
                } else {
                  _autoValidate = true;
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
              validator: validateEmail,
              onSaved: (val){
                _email = val;
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
            validator: (String value) {
              if(value.isEmpty){
                return 'Enter a valid Comapny Name';
              }
              else {
                return null;
              }
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
                          companyController.text.toUpperCase(),
                          emailController.text,
                          passwordController.text,
                        )
                            .then((_) {
                          widget.login();
                        });
                      }
                    } else {}
                  } else {_autoValidate = true;}
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
