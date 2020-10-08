import 'dart:convert';

import 'package:duit_yourself/domain/entities/user_entity.dart';

class User extends UserEntity {
  User({ String email,  String name,  String photoUrl})
      : super(email: email, name: name, photoUrl: photoUrl);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      name: json['name'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'photoURL': photoUrl
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
