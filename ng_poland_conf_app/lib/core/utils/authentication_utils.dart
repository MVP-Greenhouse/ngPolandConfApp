import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ng_poland_conf_app/features/event/datasources/data/local/rate_event_local_datasource.dart';
import 'package:ng_poland_conf_app/injectable.dart';

class AuthenticationUtils {
  const AuthenticationUtils._();

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await FirebaseFirestore.instance.clearPersistence();
    await getIt.get<RateEventLocalDataSource>().clear();
  }
}
