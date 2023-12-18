import 'package:weight_tracker/domain/entities/user.dart';
import 'package:weight_tracker/domain/repositories/auth_repository.dart';
import 'package:weight_tracker/domain/usecases/base_usecase.dart';

class AuthStateChangesUsecase extends BaseUseCase<Stream<User?>, void> {
  const AuthStateChangesUsecase({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Stream<User?> execute(void params) {
    return authRepository.onAuthStateChanges();
  }
}
