//import 'package:flutter/rendering.dart';

class User {
  String email;
  String company;
  String password;
  String apiKey;
  int id;

  User(this.email, this.company, this.password, this.apiKey, this.id);

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(parsedJson['email'],parsedJson['company'], parsedJson['password'],
        parsedJson['api_key'], parsedJson['id']);
  }
}
