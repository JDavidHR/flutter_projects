import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  final ObjectId id;
  final String email;
  final String password;

  Users({
    required this.id,
    required this.email,
    required this.password,
  });

  Users copyWith({
    ObjectId? id,
    String? email,
    String? password,
  }) =>
      Users(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  factory Users.fromRawJson(String str) => Users.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["_id"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "password": password,
      };
}
