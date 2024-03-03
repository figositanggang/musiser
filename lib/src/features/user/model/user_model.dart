import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String username;
  final String fullName;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.fullName,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "username": username,
        "fullName": fullName,
      };

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      id: snap["id"],
      email: snap["email"],
      username: snap["username"],
      fullName: snap["fullName"],
    );
  }
}
