import 'dart:async';
import 'api.dart';
import 'package:countwindowsapp/models/users/user.dart';
import 'package:countwindowsapp/models/projects/project.dart';
import 'package:countwindowsapp/models/counters/counter.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<User> registerUser(String company,
          String email, String password) =>
      apiProvider.registerUser(company, email, password);

  Future signinUser(String company, String password, String apiKey) =>
      apiProvider.signinUser(company, password, apiKey);

  Future<Project> saveProject(String projectName, String date, String apiKey) =>
      apiProvider.saveProject(projectName, date, apiKey);

  Future<Counter> saveCounter(
          String image, int value, String date, String apiKey) =>
      apiProvider.saveCounter(image, value, date, apiKey);

  Future getUserProjects(String apiKey)
  => apiProvider.getUserProjects(apiKey);
}
