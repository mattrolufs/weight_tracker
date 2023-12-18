import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracker/data/datasources/auth_datasource.dart';
import 'package:weight_tracker/domain/entities/user.dart' as user_entity;

class FirebaseAuthDatasource implements AuthDatasource {
  var firebaseAuth = FirebaseAuth.instance;

  @override
  Future<user_entity.User?> logInAnonymously() async {
    user_entity.User? signedInUser;

    try {
      final userCredential = await firebaseAuth.signInAnonymously();
      print("Signed in with temporary account.");
      if (userCredential.user != null) {
        signedInUser = user_entity.User(id: userCredential.user!.uid);
      }
      return signedInUser;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }

      return null;
    }
  }

  @override
  void logOut() {
    try {
      firebaseAuth.signOut();
      print("Signed out of temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  @override
  Stream<user_entity.User?> onAuthStateChanges() {
    return FirebaseAuth.instance.authStateChanges().map((User? user) =>
        (user == null) ? null : user_entity.User(id: user!.uid));
  }
}
