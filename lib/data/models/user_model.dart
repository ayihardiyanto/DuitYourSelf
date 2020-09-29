import 'dart:convert';
import 'package:meta/meta.dart';

import 'package:duit_yourself/domain/entities/user_entity.dart';

class User extends UserEntity {
  User({@required String uid, @required String email, @required String displayName, @required String photoUrl})
      : super(uid: uid, email: email, displayName: displayName, photoUrl: photoUrl);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      email: json['email'],
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoUrl
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
