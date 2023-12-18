import 'package:weight_tracker/data/datasources/auth_datasource.dart';
import 'package:weight_tracker/data/datasources/firebase_auth_datasource.dart';
import 'package:weight_tracker/data/datasources/firebase_weight_datasource.dart';
import 'package:weight_tracker/data/datasources/weight_datasource.dart';
import 'package:weight_tracker/data/repositories/auth_repository_impl.dart';
import 'package:weight_tracker/data/repositories/weight_repository_impl.dart';
import 'package:weight_tracker/domain/repositories/auth_repository.dart';
import 'package:weight_tracker/domain/repositories/weight_repository.dart';
import 'package:weight_tracker/domain/usecases/auth_usecases/auth_state_changes_usecase.dart';
import 'package:weight_tracker/domain/usecases/auth_usecases/signin_usecase.dart';
import 'package:weight_tracker/domain/usecases/auth_usecases/signout_usecase.dart';
import 'package:weight_tracker/domain/usecases/weight_usecases/delete_weight_usecase.dart';
import 'package:weight_tracker/domain/usecases/weight_usecases/get_weight_usecase.dart';
import 'package:weight_tracker/domain/usecases/weight_usecases/set_weight_usecase.dart';

class Injector {
  //Auth dependencies
  static AuthDatasource authDatasource = FirebaseAuthDatasource();
  static AuthRepository authRepository =
      AuthRepositoryImpl(authDatasource: authDatasource);
  static AuthStateChangesUsecase authStateChangesUsecase =
      AuthStateChangesUsecase(authRepository: authRepository);
  static SignInUsecase signInUsecase =
      SignInUsecase(authRepository: authRepository);
  static SignOutUsecase signOutUsecase =
      SignOutUsecase(authRepository: authRepository);

  //Weight dependencies
  static WeightDatasource weightDatasource = FirebaseWeightDatasource();
  static WeightRepository weightRepository =
      WeightRepositoryImpl(weightDatasource: weightDatasource);
  static GetWeightUsecase getWeightUsecase =
      GetWeightUsecase(weightRepository: weightRepository);
  static SetWeightUsecase setWeightUsecase =
      SetWeightUsecase(weightRepository: weightRepository);
  static DeleteWeightUsecase deleteWeightUsecase =
      DeleteWeightUsecase(weightRepository: weightRepository);
}
