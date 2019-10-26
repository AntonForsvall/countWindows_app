import 'dart:async';
import 'api.dart';
import 'package:countwindowsapp/models/users/user.dart';

class Repository {
  final apiProvider = ApiProvider();

  Future<User> registerUser(String firstname, String lastname, String username, String email, String password) =>
  apiProvider.registerUser(firstname, lastname, username, email, password);

  Future signinUser(String username,String password, String apiKey) =>
  apiProvider.signinUser(username, password, apiKey);
}