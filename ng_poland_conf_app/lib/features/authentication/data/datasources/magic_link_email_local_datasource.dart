import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/data/hive_store.dart';

abstract interface class MagicLinkEmailLocalDataSource {
  Future<void> savePendingEmail(String email);

  Future<String?> getPendingEmail();

  Future<void> clearPendingEmail();
}

@Singleton(as: MagicLinkEmailLocalDataSource)
class MagicLinkEmailLocalDataSourceImpl
    implements MagicLinkEmailLocalDataSource {
  const MagicLinkEmailLocalDataSourceImpl(this._store);

  static const String _nameBox = HiveConstantsForBoxes.magicLinkPendingEmail;
  static const String _emailKey = HiveConstantsForBoxes.defaultKey;
  static const String _savedAtKey = 'savedAt';
  static const Duration pendingEmailTtl = Duration(hours: 1);

  final HiveStore _store;

  @override
  Future<void> savePendingEmail(String email) async {
    await _store.save<String>(_nameBox, _emailKey, email);
    await _store.save<String>(
      _nameBox,
      _savedAtKey,
      DateTime.now().toUtc().toIso8601String(),
    );
  }

  @override
  Future<String?> getPendingEmail() async {
    final email = await _store.get<String>(_nameBox, _emailKey);
    if (email == null || email.isEmpty) return null;

    final savedAtRaw = await _store.get<String>(_nameBox, _savedAtKey);
    if (savedAtRaw == null) {
      // Legacy entry without TTL — refresh timestamp so it remains usable once.
      await _store.save<String>(
        _nameBox,
        _savedAtKey,
        DateTime.now().toUtc().toIso8601String(),
      );
      return email;
    }

    final savedAt = DateTime.tryParse(savedAtRaw);
    if (savedAt == null ||
        DateTime.now().toUtc().difference(savedAt) > pendingEmailTtl) {
      await clearPendingEmail();
      return null;
    }

    return email;
  }

  @override
  Future<void> clearPendingEmail() async {
    await _store.clear<String>(_nameBox);
  }
}
