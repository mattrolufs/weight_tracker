import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_tracker/domain/entities/user.dart';
import 'package:weight_tracker/domain/usecases/auth_usecases/auth_state_changes_usecase.dart';
import 'package:weight_tracker/domain/usecases/auth_usecases/signin_usecase.dart';
import 'package:weight_tracker/domain/usecases/auth_usecases/signout_usecase.dart';
import 'package:weight_tracker/presentation/injector.dart';

final loaderStateProvider = StateProvider<bool>((ref) => false);

final authProvider = StateProvider<User?>((ref) => null);

final authScreenViewModelProvider = Provider.autoDispose<AuthScreenViewModel>(
  (ref) => AuthScreenViewModel(ref,
      authStateChangesUsecase: Injector.authStateChangesUsecase,
      signInUsecase: Injector.signInUsecase,
      signOutUsecase: Injector.signOutUsecase),
);

class AuthScreenViewModel {
  late ProviderRef ref;
  late AuthStateChangesUsecase authStateChangesUsecase;
  late SignInUsecase signInUsecase;
  late SignOutUsecase signOutUsecase;
  static final AuthScreenViewModel _singleton = AuthScreenViewModel._internal();

  factory AuthScreenViewModel(ProviderRef reference,
      {required AuthStateChangesUsecase authStateChangesUsecase,
      required SignInUsecase signInUsecase,
      required SignOutUsecase signOutUsecase}) {
    _singleton.ref = reference;
    _singleton.authStateChangesUsecase = authStateChangesUsecase;
    _singleton.signInUsecase = signInUsecase;
    _singleton.signOutUsecase = signOutUsecase;
    return _singleton;
  }

  AuthScreenViewModel._internal();

  User? user;

  Stream<User?> onAuthStateChanges() {
    return authStateChangesUsecase.execute(null);
  }

  Future<User?> signIn() async {
    try {
      user = await signInUsecase.execute(null);
      return user;
    } catch (e) {
      ref.read(loaderStateProvider.notifier).state = false;
    }
    return null;
  }

  void signOut() {
    try {
      signOutUsecase.execute(null);
    } catch (e) {
      ref.read(loaderStateProvider.notifier).state = false;
    }
  }
}
