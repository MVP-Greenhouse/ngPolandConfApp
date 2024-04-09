import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class RateSpeakersRemoteDataSource {
  const RateSpeakersRemoteDataSource();

  Future<int> rateSpeaker({
    required String confId,
    required String speakerId,
    required int rate,
  });

  Future<int> getRateForSpeaker({
    required String confId,
    required String speakerId,
  });
}

@Singleton(as: RateSpeakersRemoteDataSource)
class RateSpeakersRemoteDataSourceImpl implements RateSpeakersRemoteDataSource {
  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  @override
  Future<int> getRateForSpeaker({
    required String confId,
    required String speakerId,
  }) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await FirebaseFirestore.instance.collection('conf').doc(confId).collection('speakers').doc(speakerId).collection('rates').doc(_uid).get();
    Map<String, dynamic>? data = document.data();
    return cast<int>(data?.entries.firstOrNull?.value);
  }

  @override
  Future<int> rateSpeaker({
    required String confId,
    required String speakerId,
    required int rate,
  }) async {
    await FirebaseFirestore.instance.collection('conf').doc(confId).collection('speakers').doc(speakerId).collection('rates').doc(_uid).set(
      {'rate': rate},
    );
    return rate;
  }
}
