import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:countwindowsapp/models/users/user.dart';
import 'package:countwindowsapp/models/projects/project.dart';
import 'package:countwindowsapp/models/counters/counter.dart';

class ApiProvider {
  Client client = Client();

  Future<User> registerUser(String firstname, String lastname, String username,
      String email, String password) async {
    final response = await client.post('http://127.0.0.1:5000/api/Register',
        body: jsonEncode({
          'firstname': firstname,
          'lastname': lastname,
          'username': username,
          'email': email,
          'password': password
        }));

    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // if the call to the server was successful, parse the JSON
      await saveApiKey(result['data']['api_key']);
      return User.fromJson(result['data']);
    } else {
      //if that call was not successful, throw an error
      throw Exception('failed to load post');
    }
  }

  Future<User> fetchUser() async {
  final response =
      await client.get('http://127.0.0.1:5000/api/Register');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return User.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

  Future signinUser(String username, String password, String apiKey) async {
    final response = await client.post('http://127.0.0.1:5000/api/signin',
        headers: {"Authorization": apiKey},
        body: jsonEncode({
          "username": username,
          "password": password,
        }));
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      await saveApiKey(result["data"]["api_key"]);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<Project> saveProject(
      String projectName, String date, String apiKey) async {
    final response = await client.post('http://127.0.0.1:5000/api/project',
        headers: {"Authorization": apiKey},
        body: jsonEncode({"project_name": projectName, "date": date}));
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // if the call to the server was successful, parse the JSON
      await saveApiKey(result['data']['api_key']);
      return Project.fromJson(result['data']);
    } else {
      //if that call was not successful, throw an error
      throw Exception('failed to load post');
    }
  }

  Project projectFromJson(String str) {    
   final jsonData = json.decode(str);    
   return Project.fromJson(jsonData);
}

Future<Project> getProject() async{
  final response = await client.get('http://127.0.0.1:5000/api/project');
  return projectFromJson(response.body);
}

  Future<List<Project>> getProjectData(String apiKey) async {
  List<Project> projectList;
    String link =
          'http://127.0.0.1:5000/api/project';
    var response = await client
        .get(Uri.encodeFull(link), headers: {"Authorization": apiKey});
    print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var rest = data as List;
        await saveApiKey(data['data']['api_key']);
        print(rest);
        projectList = rest.map<Project>((json) => Project.fromJson(json)).toList();
      }
    print("List Size: ${projectList.length}");
    return projectList;
  }

  Future<Counter> saveCounter(
      String image, int value, String date, String apiKey) async {
    final response = await client.post('http://127.0.0.1:5000/api/counter',
        headers: {"Authorization": apiKey},
        body: jsonEncode({"image": image, "value": value, "date": date}));
    final Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      // if the call to the server was successful, parse the JSON
      await saveApiKey(result['data']['api_key']);
      return Counter.fromJson(result['data']);
    } else {
      //if that call was not successful, throw an error
      throw Exception('failed to load post');
    }
  }

  saveApiKey(String apiKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('API_Token', apiKey);
  }
}
