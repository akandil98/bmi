import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bmi/services/cloud/cloud_storage_constants.dart';
import 'package:flutter/foundation.dart';

@immutable
class CloudNote {
  final String documentId;
  final String ownerUserId;
  final double weightVal;
  final double heightVal;
  final double bmiVal;
  final DateTime createdAtVal;

  const CloudNote({
    required this.documentId,
    required this.ownerUserId,
    required this.weightVal,
    required this.heightVal,
    required this.bmiVal,
    required this.createdAtVal,
  });

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        weightVal = snapshot.data()[weight] as double,
        heightVal = snapshot.data()[height] as double,
        bmiVal = snapshot.data()[bmi] as double,
        createdAtVal = (snapshot.data()[createdAt] as Timestamp).toDate();
}
