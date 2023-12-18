import 'package:weight_tracker/domain/entities/weight.dart';
import 'package:weight_tracker/domain/repositories/weight_repository.dart';
import 'package:weight_tracker/domain/usecases/base_usecase.dart';

class EditWeightUsecase extends BaseUseCase<void, EditWeightParams> {
  EditWeightUsecase({required this.weightRepository});

  final WeightRepository weightRepository;

  @override
  void execute(EditWeightParams params) {
    weightRepository.setWeight(weight: params.weight);
  }
}

class EditWeightParams {
  EditWeightParams({required this.weight}) : super();

  final Weight weight;
}
