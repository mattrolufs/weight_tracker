import 'package:weight_tracker/domain/repositories/auth_repository.dart';
import 'package:weight_tracker/domain/usecases/base_usecase.dart';

class SignOutUsecase extends BaseUseCase<void, void> {
  const SignOutUsecase({required this.authRepository});
  final AuthRepository authRepository;

  @override
  void execute(void params) {
    authRepository.logOut();
  }
}
