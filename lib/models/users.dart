import 'dart:convert';
import 'package:flutter/widgets.dart';

class User {
  final int? user_id;
  final String? f_name;
  final String? l_name;
  final String username;
  final String password;
  final String? mobilehp;

  User({
    this.user_id,
    this.f_name,
    this.l_name,
    required this.username,
    required this.password,
    this.mobilehp,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'f_name': f_name,
      'l_name': l_name,
      'username': username,
      'password': password,
      'mobilehp': mobilehp,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      user_id: map['user_id']?.toInt() ?? 0,
      f_name: map['f_name'] ?? "",
      l_name: map['l_name'] ?? "",
      username: map['username'] ?? "",
      password: map['password'] ?? "",
      mobilehp: map['mobilehp'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
  @override
  String toString() {
    return 'User(user_id: $user_id, f_name: $f_name, l_name: $l_name, username: $username, password: $password, mobilehp: $mobilehp)';
  }
}
