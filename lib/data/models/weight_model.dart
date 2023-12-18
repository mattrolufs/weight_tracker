import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weight_tracker/data/models/data_mapper.dart';
import 'package:weight_tracker/data/repositories/auth_repository_impl.dart';
import 'package:weight_tracker/domain/entities/weight.dart';

class WeightModel implements DataMapper<Weight> {
  final double weight;
  final DateTime timestamp;
  final String userId;
  final String itemId;

  WeightModel(
      {required this.weight,
      required this.timestamp,
      required this.userId,
      required this.itemId});

  factory WeightModel.fromFirebaseSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return WeightModel(
      weight: data['weight'] as double,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      userId: data['userid'] as String,
      itemId: snapshot.reference.id,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'weight': weight,
      'userid': AuthRepositoryImpl.user?.id ?? '',
      'timestamp': timestamp,
      'itemId': itemId,
    };
  }

  @override
  Weight mapToEntity() {
    return Weight(
        weight: weight, itemId: itemId, userId: userId, timestamp: timestamp);
  }
}
