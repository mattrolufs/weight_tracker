import 'package:weight_tracker/data/datasources/auth_datasource.dart';
import 'package:weight_tracker/domain/entities/user.dart';
import 'package:weight_tracker/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.authDatasource});

  final AuthDatasource authDatasource;
  static User? user;

  @override
  Future<User?> logInAnonymously() async {
    user = await authDatasource.logInAnonymously();
    return user;
  }

  @override
  void logOut() {
    authDatasource.logOut();
  }

  @override
  Stream<User?> onAuthStateChanges() {
    return authDatasource
        .onAuthStateChanges()
        .map((User? localUser) => user = localUser);
    //return authDatasource.onAuthStateChanges();
  }
}
