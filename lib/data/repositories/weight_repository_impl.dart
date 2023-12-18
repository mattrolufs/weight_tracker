import 'package:weight_tracker/data/datasources/weight_datasource.dart';
import 'package:weight_tracker/domain/entities/weight.dart';
import 'package:weight_tracker/domain/repositories/weight_repository.dart';

class WeightRepositoryImpl implements WeightRepository {
  WeightRepositoryImpl({required this.weightDatasource});

  final WeightDatasource weightDatasource;

  @override
  Stream<List<Weight>?> getWeights() {
    return weightDatasource.getWeights();
  }

  @override
  void setWeight({required Weight weight}) {
    weightDatasource.setWeight(weight: weight);
  }

  @override
  void deleteWeight({required Weight weight}) {
    weightDatasource.deleteWeight(weight: weight);
  }
}
