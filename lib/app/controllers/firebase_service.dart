import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() => _instance;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore data = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  FirebaseService._internal();
}
