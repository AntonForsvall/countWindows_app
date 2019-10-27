import 'dart:async';
import 'api.dart';
import 'package:countwindowsapp/models/users/user.dart';
import 'package:countwindowsapp/models/projects/project.dart';
import 'package:countwindowsapp/models/counters/counter.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<User> registerUser(String firstname, String lastname, String username,
          String email, String password) =>
      apiProvider.registerUser(firstname, lastname, username, email, password);

  Future signinUser(String username, String password, String apiKey) =>
      apiProvider.signinUser(username, password, apiKey);

  Future<Project> saveProject(String projectName, String date, String apiKey) =>
      apiProvider.saveProject(projectName, date, apiKey);

  Future<Counter> saveCounter(
          String image, int value, String date, String apiKey) =>
      apiProvider.saveCounter(image, value, date, apiKey);
}
