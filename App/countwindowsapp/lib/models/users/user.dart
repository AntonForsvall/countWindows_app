//import 'package:flutter/rendering.dart';

class User {
  String firstname;
  String lastname;
  String username;
  String email;
  String password;
  String apiKey;
  int id;

  User(this.firstname, this.lastname, this.username, this.email, this.password,
      this.apiKey, this.id);

  factory User.fromJson(Map<String, dynamic> parsedJson){
    return User(
      parsedJson['firstname'],
      parsedJson['lastname'],
      parsedJson['username'],
      parsedJson['email'],
      parsedJson['password'],
      parsedJson['api_key'],
      parsedJson['id']
  );
  }
}
