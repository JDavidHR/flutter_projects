import 'dart:convert';

class Users {
  final String email;
  final String password;

  Users({
    required this.email,
    required this.password,
  });

  Users copyWith({
    String? email,
    String? password,
  }) =>
      Users(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  factory Users.fromRawJson(String str) => Users.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
