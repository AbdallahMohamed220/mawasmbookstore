import 'package:flutter/material.dart';

class UserModel {
  String name;
  String email;
  String password;

  UserModel({
    this.email,
    this.name,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map.addAll({
      'email': email,
      'name': name,
      'password': password,
    });
    return map;
  }
}
