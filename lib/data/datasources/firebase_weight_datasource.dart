import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weight_tracker/data/datasources/weight_datasource.dart';
import 'package:weight_tracker/data/models/weight_model.dart';
import 'package:weight_tracker/domain/entities/weight.dart';

class FirebaseWeightDatasource implements WeightDatasource {
  final weightsCollection = FirebaseFirestore.instance.collection("weights");

  @override
  Stream<List<Weight>?> getWeights() {
    return weightsCollection
        .where("userid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((qShot) => qShot.docs
            .map((doc) => WeightModel.fromFirebaseSnapshot(doc).mapToEntity())
            .toList());
  }

  @override
  void setWeight({required Weight weight}) {
    Map<String, dynamic> json = WeightModel(
            weight: weight.weight,
            timestamp: weight.timestamp ?? DateTime.now(),
            userId: FirebaseAuth.instance.currentUser?.uid ?? '',
            itemId: weight.itemId ?? '')
        .toJson();

    if (weight.itemId == null) {
      weightsCollection.add(json);
    } else {
      weightsCollection.doc(weight.itemId).update(json);
    }
  }

  @override
  void deleteWeight({required Weight weight}) {
    weightsCollection.doc(weight.itemId).delete();
  }
}
