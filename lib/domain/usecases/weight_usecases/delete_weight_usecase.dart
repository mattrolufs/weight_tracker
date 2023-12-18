import 'package:weight_tracker/domain/entities/weight.dart';
import 'package:weight_tracker/domain/repositories/weight_repository.dart';
import 'package:weight_tracker/domain/usecases/base_usecase.dart';

class DeleteWeightUsecase extends BaseUseCase<void, DeleteWeightParams> {
  DeleteWeightUsecase({required this.weightRepository});

  final WeightRepository weightRepository;

  @override
  void execute(DeleteWeightParams params) {
    weightRepository.deleteWeight(weight: params.weight);
  }
}

class DeleteWeightParams {
  DeleteWeightParams({required this.weight}) : super();

  final Weight weight;
}
