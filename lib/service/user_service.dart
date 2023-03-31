import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myproject_app/model/user.dart';

class UserService {
  static Stream<List<Users>> readUser() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Users.fromMap(doc.data()))
          .where((element) =>
              element.email == FirebaseAuth.instance.currentUser!.email)
          .toList());
}
