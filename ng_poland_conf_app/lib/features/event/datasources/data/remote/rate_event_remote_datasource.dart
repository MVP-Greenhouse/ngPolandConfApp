import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class RateEventRemoteDataSource {
  const RateEventRemoteDataSource();

  Future<int> rateEvent({
    required String confId,
    required String eventId,
    required String eventItemType,
    required int rate,
  });

  Future<int> getRateForEvent({
    required String confId,
    required String eventId,
    required String eventItemType,
  });
}

@Singleton(as: RateEventRemoteDataSource)
class RateEventRemoteDataSourceImpl implements RateEventRemoteDataSource {
  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  @override
  Future<int> getRateForEvent({
    required String confId,
    required String eventId,
    required String eventItemType,
  }) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await FirebaseFirestore.instance.collection('conf').doc(confId).collection(eventItemType).doc(eventId).collection('rates').doc(_uid).get();
    Map<String, dynamic>? data = document.data();
    return cast<int>(data?.entries.firstOrNull?.value);
  }

  @override
  Future<int> rateEvent({
    required String confId,
    required String eventId,
    required String eventItemType,
    required int rate,
  }) async {
    await FirebaseFirestore.instance.collection('conf').doc(confId).collection(eventItemType).doc(eventId).collection('rates').doc(_uid).set(
      {'rate': rate},
    );
    return rate;
  }
}
