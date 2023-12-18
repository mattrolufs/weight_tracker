import 'package:weight_tracker/domain/entities/weight.dart';
import 'package:weight_tracker/domain/repositories/weight_repository.dart';
import 'package:weight_tracker/domain/usecases/base_usecase.dart';

class SetWeightUsecase extends BaseUseCase<void, SetWeightParams> {
  SetWeightUsecase({required this.weightRepository});

  final WeightRepository weightRepository;

  @override
  void execute(SetWeightParams params) {
    weightRepository.setWeight(weight: params.weight);
  }
}

class SetWeightParams {
  SetWeightParams({required this.weight}) : super();

  final Weight weight;
}
