import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as _firebase;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:localstorage/localstorage.dart';
import 'package:duit_yourself/common/constants/common_constants.dart';
import 'package:duit_yourself/common/constants/key_cache_constant.dart';
import 'package:duit_yourself/common/constants/key_local_storage_constants.dart';
import 'package:duit_yourself/domain/repositories/user_repository.dart';
import '../models/user_model.dart';
import 'package:simple_cache/simple_cache.dart';
import 'package:http/http.dart' as http;

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final LocalStorage storage =
      LocalStorage(KeyLocalStorageConstants.userDetail);
  final _firebase.FirebaseAuth _firebaseAuth = _firebase.FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn =
      GoogleSignIn(clientId: CommonConstants.googleSignInClientId);
  SimpleCache simpleCache;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String _baseUrl = 'http://localhost:3210';
  http.Client httpClient = http.Client();

  Future saveCacheData(String user) async {
    simpleCache = await SimpleCache.getInstance();
    await simpleCache.setString(KeyCacheConstants.cacheUsernameKey, user);
  }

  User _userFromFirebase(_firebase.User user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signIn({bool isGoogle, String email, String password}) async {
    print('Masuk');
    var authResult;

    try {
      if (isGoogle) {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser.authentication;
        final credential = _firebase.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        authResult = await _firebaseAuth.signInWithCredential(credential);
      } else {
        authResult = await _firebaseAuth
            .signInWithEmailAndPassword(
              email: email,
              password: password,
            )
            .catchError((error) => print(error));
      }
    } catch (_) {
      print(_);
    }
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    await Future.wait([_firebaseAuth.signOut(), _googleSignIn.disconnect()]);
  }

  @override
  Future<User> currentUser() async {
    final user = _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future saveToLocalStorage(String key, String value) async {
    await storage.setItem(key, value);
    return key;
  }

  @override
  Future getFromLocalStorage(String key) async {
    var getRole = storage.getItem(key);
    return getRole;
  }

  @override
  Future<bool> isSignedIn() async {
    var currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> signInCheck() async {
    final currentUser = await _firebaseAuth.authStateChanges().first;
    if (currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<String> getRoles() async {
    try {
      String role;
      var user = await currentUser();
      final currentEmail = user.email;
      var a = firestore.app.name;
      print('oke fire $a');
      var collectionReference = firestore.collection('user');
      return collectionReference
          .where('platform', isEqualTo: true)
          .where('email', arrayContains: currentEmail)
          .get()
          .then((value) async {
        // ignore: avoid_function_literals_in_foreach_calls
        value.docs.forEach((element) {
          role = element.id;
        });
        var key = KeyLocalStorageConstants.role;
        await saveToLocalStorage(key, role);
        return role;
      });
    } catch (error) {
      throw 'unauthorized';
    }
  }

  @override
  Future<String> getUser() async {
    var user = await currentUser();
    final currentName = user.displayName;
    var key = KeyLocalStorageConstants.username;
    await saveToLocalStorage(key, currentName);
    await saveCacheData(currentName);
    return currentName;
  }

  @override
  Future<String> getPhoto() async {
    var user = await currentUser();
    final currentPhoto = user.photoUrl;
    var key = KeyLocalStorageConstants.photo;
    await saveToLocalStorage(key, currentPhoto);
    return currentPhoto;
  }

  @override
  Future<String> signUp({String email, String password}) async {
    final result = await http.post('$_baseUrl/create-user', body: {
      'email': email,
      'password': password,
    },);
    return result.body;
  }
}
