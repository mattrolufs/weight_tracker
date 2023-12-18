import 'package:weight_tracker/domain/entities/weight.dart';

abstract class WeightRepository {
  Stream<List<Weight>?> getWeights();
  void setWeight({required Weight weight});
  void deleteWeight({required Weight weight});
}
