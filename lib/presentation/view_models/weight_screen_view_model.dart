import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/domain/entities/user.dart';
import 'package:weight_tracker/domain/entities/weight.dart';
import 'package:weight_tracker/domain/usecases/weight_usecases/delete_weight_usecase.dart';
import 'package:weight_tracker/domain/usecases/weight_usecases/get_weight_usecase.dart';
import 'package:weight_tracker/domain/usecases/weight_usecases/set_weight_usecase.dart';
import 'package:weight_tracker/presentation/injector.dart';

final loaderStateProvider = StateProvider<bool>((ref) => false);

final authProvider = StateProvider<User?>((ref) => null);

final weightScreenViewModelProvider =
    Provider.autoDispose<WeightScreenViewModel>(
  (ref) => WeightScreenViewModel(ref,
      setWeightUsecase: Injector.setWeightUsecase,
      getWeightUsecase: Injector.getWeightUsecase,
      deleteWeightUsecase: Injector.deleteWeightUsecase),
);

class WeightScreenViewModel {
  late ProviderRef ref;
  late SetWeightUsecase setWeightUsecase;
  late GetWeightUsecase getWeightUsecase;
  late DeleteWeightUsecase deleteWeightUsecase;
  static final WeightScreenViewModel _singleton =
      WeightScreenViewModel._internal();

  factory WeightScreenViewModel(ProviderRef reference,
      {required SetWeightUsecase setWeightUsecase,
      required GetWeightUsecase getWeightUsecase,
      required DeleteWeightUsecase deleteWeightUsecase}) {
    _singleton.ref = reference;
    _singleton.setWeightUsecase = setWeightUsecase;
    _singleton.getWeightUsecase = getWeightUsecase;
    _singleton.deleteWeightUsecase = deleteWeightUsecase;
    return _singleton;
  }

  WeightScreenViewModel._internal();

  Stream<List<Weight>?> weights = const Stream<List<Weight>?>.empty();

  Stream<List<Weight>?> getWeights() {
    try {
      weights = getWeightUsecase.execute(null);
    } catch (e) {
      ref.read(loaderStateProvider.notifier).state = false;
    }
    return weights;
  }

  void setWeight(Weight weight) {
    try {
      setWeightUsecase.execute(SetWeightParams(weight: weight));
    } catch (e) {
      ref.read(loaderStateProvider.notifier).state = false;
    }
  }

  void deleteWeight(Weight weight) {
    try {
      deleteWeightUsecase.execute(DeleteWeightParams(weight: weight));
    } catch (e) {
      ref.read(loaderStateProvider.notifier).state = false;
    }
  }

  String formatDateTime(DateTime timestamp) {
    return DateFormat('MMMM dd, yyyy hh:mm:ss').format(timestamp);
  }
}
