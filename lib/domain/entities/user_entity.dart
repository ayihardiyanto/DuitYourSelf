import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  final String email;
  final String name;
  final String photoUrl;

  UserEntity({
    @required this.email,
    @required this.name,
    @required this.photoUrl,
  });

  @override
  List<Object> get props => [ email, name, photoUrl];

  UserEntity copyWith({
    String email,
    String name,
    String photoUrl,
  }) =>
      UserEntity(
        email: email ?? this.email,
        name: name ?? this.name,
        photoUrl: photoUrl ?? this.photoUrl,
      );
}
