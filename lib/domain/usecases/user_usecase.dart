import 'package:duit_yourself/common/models/usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:duit_yourself/data/models/user_model.dart';
import 'package:duit_yourself/domain/entities/user_entity.dart';
import 'package:duit_yourself/domain/repositories/user_repository.dart';

@injectable
@lazySingleton
class UserUsecase implements UseCase<UserEntity, Map<String, String>> {
  final UserRepository userRepository;

  UserUsecase(this.userRepository);

  @override
  Future<UserEntity> call(Map payload) {
    return null;
  }

  Future<bool> isSignedIn() {
    return userRepository.isSignedIn();
  }

  Future<void> signOut() {
    return userRepository.signOut();
  }

  Future<User> signIn({bool isGoogle, String email, String password}) {
    return userRepository.signIn(isGoogle: isGoogle, email: email, password:password);
  }

  Future<String> getRoles() {
    return userRepository.getRoles();
  }

  Future<String> getUser() {
    return userRepository.getUser();
  }

  Future<String> getPhoto() {
    return userRepository.getPhoto();
  }

  Future<bool> signInCheck() {
    return userRepository.signInCheck();
  }

}
