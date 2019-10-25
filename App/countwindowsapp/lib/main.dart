import 'package:flutter/material.dart';
import 'package:countwindowsapp/Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:countwindowsapp/models/users/user_bloc_provider.dart';
import 'package:countwindowsapp/Screens/countWindows.dart';


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

class _HomePageState extends State <HomePage>{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: signinUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          String apiKey = "";
          if (snapshot.hasData) {
            apiKey = snapshot.data;
          } else {
            print("No data");
          }
          // String apiKey = snapshot.data;
          //apiKey.length > 0 ? getHomePage() : 
          return apiKey.length > 0 ? getHomePage() : LoginPage(login: login, newUser: false,);
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
    bloc.signinUser("", "", apiKey);
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
    return MaterialApp(
      color: Colors.yellow,
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: new Scaffold(
            body: Stack(children: <Widget>[
              TabBarView(
                children: [
                  CountWindows(),
                  new Container(
                    color: Colors.orange,
                  ),
                  new Container(
                    child: Center(
                       child: FlatButton(
                         child: Text("Log out"),
                         onPressed: () {
                           logout();
                         },
                       ),
                    ),
                    color: Colors.lightGreen,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 50),
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Window Counter",
                    ),
                    Container()
                  ],
                ),
              ),
              Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.only(
                    top: 120,
                    left: MediaQuery.of(context).size.width * 0.5 - 40),
                child: FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    size: 70,
                  ),
                  onPressed: () {},
                ),
              )
            ]),
            appBar: AppBar(
              elevation: 0,
              title: new TabBar(
                tabs: [
                  Tab(
                    icon: new Icon(Icons.home),
                  ),
                  Tab(
                    icon: new Icon(Icons.rss_feed),
                  ),
                  Tab(
                    icon: new Icon(Icons.perm_identity),
                  ),
                ],
                unselectedLabelColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.transparent,
              ),
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
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




