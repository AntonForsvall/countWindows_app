import 'dart:async';
import 'package:http/http.dart' show Client;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:countwindowsapp/models/users/user.dart';
import 'package:countwindowsapp/models/projects/project.dart';
import 'package:countwindowsapp/models/counters/counter.dart';

class ApiProvider {
  Client client = Client();

  Future<User> registerUser(String company,
      String email, String password) async {
    final response = await client.post('http://127.0.0.1:5000/api/Register',
        body: jsonEncode({
          'company': company,
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


  Future signinUser(String company, String password, String apiKey) async {
    final response = await client.post('http://127.0.0.1:5000/api/signin',
        headers: {"Authorization": apiKey},
        body: jsonEncode({
          "company": company,
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

  Future <List<Project>> getUserProjects(String apiKey) async {
    final response = await client.get('http://127.0.0.1:5000/api/project', headers: {
      'Authorization' : apiKey
    });
    final  Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      List<Project> projects = [];
      for (Map json_ in result['data']){
        try {
          projects.add(Project.fromJson(json_));
        }
        catch(Exception) {
          print(Exception);
        }
      }
      for (Project project in projects) {
        print(project.id);
      }
      return projects;
    }
    else {
      // if that call was not successful, throw an error
      throw Exception('Failed to load projects');
    }
  }

  Future <List<Counter>> getUserCounters(String apiKey, int projectId) async {
    final response = await client.get('http://127.0.0.1:5000/api/counter', headers: {
      'Authorization' : apiKey
    });
    final  Map result = json.decode(response.body);
    if (response.statusCode == 201) {
      List<Counter> counters = [];
      for (Map json_ in result['data']){
        try {
            print(json_);
            counters.add(Counter.fromJson(json_));
        }
        catch(Exception) {
          print(Exception);
        }
      }
      for (Counter counter in counters) {
        print(counter.id);
        print(counter.projectId);
      }
      return counters;
    }
    else {
      // if that call was not successful, throw an error
      throw Exception('Failed to load projects');
    }
  }

  saveApiKey(String apiKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('API_Token', apiKey);
  }
}
