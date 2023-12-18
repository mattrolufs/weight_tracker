import 'package:weight_tracker/domain/entities/user.dart';
import 'package:weight_tracker/domain/repositories/auth_repository.dart';
import 'package:weight_tracker/domain/usecases/base_usecase.dart';

class SignInUsecase extends BaseUseCase<Future<User?>, void> {
  const SignInUsecase({required this.authRepository});
  final AuthRepository authRepository;

  @override
  Future<User?> execute(void params) {
    return authRepository.logInAnonymously();
  }
}
