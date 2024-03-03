import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musiser/src/features/user/model/user_model.dart';

class AuthHelper {
  static final auth = FirebaseAuth.instance;
  static final store = FirebaseFirestore.instance;

  static final _users = store.collection("users");

  // ! Create account
  static Future<String> createAccount({
    required String email,
    required String username,
    required String fullName,
    required String password,
  }) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _users.doc(userCredential.user!.uid).set(
            UserModel(
              id: userCredential.user!.uid,
              email: email,
              username: username,
              fullName: fullName,
            ).toMap(),
          );

      return "Y";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  // ! Login
  static Future<String> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      return "Y";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  // ! Check username
  static Future<bool> checkUsername(String username) async {
    try {
      final snapshots = await _users.get();

      List<UserModel> users =
          snapshots.docs.map((e) => UserModel.fromSnapshot(e)).toList();

      for (var user in users) {
        if (username == user.username) {
          return true;
        }
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  // ! Logout
  static Future logOut() async {
    try {
      await auth.signOut();
    } catch (_) {}
  }
}
