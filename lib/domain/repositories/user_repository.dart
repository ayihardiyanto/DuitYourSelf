
import 'package:duit_yourself/data/models/user_model.dart';

abstract class UserRepository {
  Future<User> signIn({bool isGoogle, String email, String password});
  Future<void> signOut();
  Future<User> currentUser();
  Future<bool> isSignedIn();
  Future<String> getUser();
  Future getPhoto();
  Future<String> getData();
  Future saveToLocalStorage(String key, String value);
  Future getFromLocalStorage(String key); 
  Future<bool> signInCheck();
  Future<String> signUp({String email, String password});
}
