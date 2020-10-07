import 'package:injectable/injectable.dart';
import 'package:duit_yourself/data/models/user_model.dart';
import 'package:duit_yourself/domain/repositories/user_repository.dart';

@injectable
@lazySingleton
class UserUsecase {
  final UserRepository userRepository;

  UserUsecase(this.userRepository);

  Future<bool> isSignedIn() {
    return userRepository.isSignedIn();
  }

  Future<void> signOut() {
    return userRepository.signOut();
  }

  Future<User> signIn({bool isGoogle, String email, String password}) {
    return userRepository.signIn(
        isGoogle: isGoogle, email: email, password: password);
  }

  Future<String> signUp({String email, String password}) async {
    final result =
        await userRepository.signUp(email: email, password: password);
    return result;
  }

  Future<String> getData() async {
    try {
      return await userRepository.getData();
    } catch (_) {
      print(_);
      throw (_);
    }
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
