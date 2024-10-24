import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuth => auth.authStateChanges();

  User? get currentUser => auth.currentUser;

  Future<void> deleteUser() async {
    if (currentUser != null) {
      await currentUser!.delete();
    }
  }
}
