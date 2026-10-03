import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:ng_poland_conf_app/features/event/datasources/data/local/rate_event_local_datasource.dart';
import 'package:ng_poland_conf_app/injectable.dart';

class AuthenticationUtils {
  const AuthenticationUtils._();

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    try {
      await FirebaseFirestore.instance.clearPersistence();
    } on FirebaseException catch (e, st) {
      if (e.code != 'failed-precondition') {
        debugPrint('AuthenticationUtils.logout: clearPersistence failed');
        debugPrint('$e');
        debugPrint('$st');
      }
    } catch (e, st) {
      debugPrint('AuthenticationUtils.logout: clearPersistence failed');
      debugPrint('$e');
      debugPrint('$st');
    }
    await getIt.get<RateEventLocalDataSource>().clear();
  }
}
