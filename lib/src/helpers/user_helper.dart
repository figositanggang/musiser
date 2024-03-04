import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musiser/src/features/user/model/user_model.dart';

class UserHelper {
  static final store = FirebaseFirestore.instance;
  static final _users = store.collection("users");

  static Future<UserModel?> getUser(String userId) async {
    try {
      DocumentSnapshot snapshot = await _users.doc(userId).get();

      return UserModel.fromSnapshot(snapshot);
    } catch (e) {
      return null;
    }
  }
}
