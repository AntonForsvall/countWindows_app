import 'package:flutter/material.dart';
import 'package:countwindowsapp/Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:countwindowsapp/models/users/user_bloc_provider.dart';
import 'package:countwindowsapp/Screens/projectPage.dart';
import 'package:countwindowsapp/models/projects/project_bloc_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String apiKey = "";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: signinUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          apiKey = snapshot.data;
        } else {
          print("No data");
        }
        // String apiKey = snapshot.data;
        //apiKey.length > 0 ? getHomePage() :
        return apiKey.length > 0
            ? getHomePage()
            : LoginPage(
                login: login,
              );
      },
    );
  }

  void login() {
    setState(() {
      build(context);
    });
  }

  Future signinUser() async {
    String apiKey = await getApiKey();
    if (apiKey.length > 0) {
      userBloc.signinUser("", "", apiKey);
      print(apiKey);
    } else {
      print("No api key");
    }
    return apiKey;
  }

  Future getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("API_Token");
  }

  Widget getHomePage() {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.yellow,
      home: new Scaffold(
          appBar: AppBar(
            title: Text('Your Projects', style: TextStyle(color: Colors.white),),
            backgroundColor: Color(0xF50B1F3D),
            bottomOpacity: 0,
            elevation: 0,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.settings, color: Colors.white, size: 30,), onPressed: (){}),
              SizedBox(width: 10,),
              IconButton(icon:Icon(Icons.exit_to_app, size: 30,),
                  onPressed: () {
                    logout();
                  },
                ),
                
                
                ],
          ),
          body: ProjectPage(apiKey: apiKey,)
      )
    );
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("API_Token", "");
    setState(() {
      build(context);
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
