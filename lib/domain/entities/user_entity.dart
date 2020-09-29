import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;

  UserEntity({
    @required this.uid,
    @required this.email,
    @required this.displayName,
    @required this.photoUrl,
  });

  @override
  List<Object> get props => [uid, email, displayName, photoUrl];

  UserEntity copyWith({
    String uid,
    String email,
    String displayName,
    String photoUrl,
  }) =>
      UserEntity(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        photoUrl: photoUrl ?? this.photoUrl,
      );
}
