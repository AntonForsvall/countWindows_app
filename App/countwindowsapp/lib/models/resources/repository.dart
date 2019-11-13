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

  Future<Project> deleteProject(String apiKey, int projectId) =>
      apiProvider.deleteProject(apiKey, projectId);

  Future<Counter> saveCounter(
          String image, int value, String date, String apiKey, int projectId) =>
      apiProvider.saveCounter(image, value, date, apiKey, projectId);

  Future getUserProjects(String apiKey) async
  => await apiProvider.getUserProjects(apiKey);

  Future getUserCounters(String apiKey, int projectId)
  => apiProvider.getUserCounters(apiKey, projectId);
}
