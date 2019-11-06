import 'package:flutter/material.dart';
import 'package:countwindowsapp/Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:countwindowsapp/models/users/user_bloc_provider.dart';
import 'package:countwindowsapp/Screens/projectPage.dart';

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
    String userName = "";
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
    return await prefs.getString("API_Token");
  }

  Widget getHomePage() {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.yellow,
      home: new Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            actions: <Widget>[IconButton(icon:Icon(Icons.exit_to_app),
                  onPressed: () {
                    logout();
                  },
                ),
                ],
          ),
          body: ProjectPage(apiKey: apiKey,),
          floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: (){}, backgroundColor: Colors.blueAccent,),
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
