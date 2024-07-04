import 'package:cloud_firestore/cloud_firestore.dart';

class UsersFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUsers() async* {
    yield* _firestore.collection('users').snapshots();
  }

  void addUser({
    required String name,
    required String email,
    required String uid,
  }) {
    Map<String, dynamic> data = {
      'user-name': name,
      'user-email': email,
      'user-uid': uid,
    };
    _firestore.collection('users').add(data);
  }
}
