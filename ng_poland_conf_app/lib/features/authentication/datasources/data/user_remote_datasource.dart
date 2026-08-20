import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_profile.dart';
import 'package:ng_poland_conf_app/features/authentication/domains/entities/user_role.dart';

@injectable
class UserRemoteDataSource {
  UserRemoteDataSource({@ignoreParam FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _doc(String uid) =>
      _firestore.collection('users').doc(uid);

  Future<UserProfile> ensureProfile({
    required String uid,
    required String displayName,
    required String email,
  }) async {
    final snapshot = await _doc(uid).get();
    if (snapshot.exists) {
      return _fromDoc(uid, snapshot.data()!);
    }
    await _doc(uid).set({
      'displayName': displayName,
      'email': email,
      'role': UserRole.user.id,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return UserProfile(
      uid: uid,
      displayName: displayName,
      email: email,
      role: UserRole.user,
    );
  }

  Stream<UserProfile?> watchProfile(String uid) {
    return _doc(uid).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (!snapshot.exists || data == null) return null;
      return _fromDoc(uid, data);
    });
  }

  UserProfile _fromDoc(String uid, Map<String, dynamic> data) {
    return UserProfile(
      uid: uid,
      displayName: data['displayName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      role: UserRole.fromId(data['role'] as String?),
    );
  }
}
