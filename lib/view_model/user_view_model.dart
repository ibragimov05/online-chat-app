import 'package:chat_app/services/firebase/users_firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserViewModel {
  final UsersFirebaseService _usersFirebaseService = UsersFirebaseService();

  Stream<QuerySnapshot> getUsers() async* {
    yield* _usersFirebaseService.getUsers();
  }

  void addUser({
    required String name,
    required String email,
    required String uid,
  }) {
    _usersFirebaseService.addUser(
      name: name,
      email: email,
      uid: uid,
    );
  }
}
