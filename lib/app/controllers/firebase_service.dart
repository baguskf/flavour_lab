import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() => _instance;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore data = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Stream<DocumentSnapshot<Object?>> streamData() {
    String uid = auth.currentUser!.uid;
    DocumentReference users = data.collection('users').doc(uid);
    return users.snapshots();
  }

  Stream<User?> get streamAuth => auth.authStateChanges();

  User? get currentUser => auth.currentUser;

  Future<void> deleteUser() async {
    if (currentUser != null) {
      await currentUser!.delete();
    }
  }

  FirebaseService._internal();
}
