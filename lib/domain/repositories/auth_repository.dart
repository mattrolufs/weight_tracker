import 'package:weight_tracker/domain/entities/user.dart';

abstract class AuthRepository {
  Stream<User?> onAuthStateChanges();
  Future<User?> logInAnonymously();
  void logOut();
}
