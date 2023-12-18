import 'package:weight_tracker/domain/entities/user.dart';
import 'package:weight_tracker/domain/entities/weight.dart';
import 'package:weight_tracker/domain/repositories/weight_repository.dart';
import 'package:weight_tracker/domain/usecases/base_usecase.dart';

class GetWeightUsecase extends BaseUseCase<Stream<List<Weight>?>, void> {
  GetWeightUsecase({required this.weightRepository});

  final WeightRepository weightRepository;
  @override
  Stream<List<Weight>?> execute(void params) {
    return weightRepository.getWeights();
  }
}

class GetWeightParams {
  GetWeightParams({required this.user});

  final User user;
}
