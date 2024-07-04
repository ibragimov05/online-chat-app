import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentUser {
  final String id;
  final String uid;
  final String name;
  final String email;

  const CurrentUser({
    required this.id,
    required this.uid,
    required this.name,
    required this.email,
  });

  factory CurrentUser.fromQuerySnapshot(QueryDocumentSnapshot query) {
    return CurrentUser(
      id: query.id,
      uid: query['user-uid'],
      name: query['user-name'],
      email: query['user-email'],
    );
  }
}
