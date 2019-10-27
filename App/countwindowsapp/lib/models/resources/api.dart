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
