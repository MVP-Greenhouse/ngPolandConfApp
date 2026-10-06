import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/constants/hive_constants.dart';
import 'package:ng_poland_conf_app/core/services/hive_service.dart';

abstract class MagicLinkEmailLocalDataSource {
  Future<void> savePendingEmail(String email);

  Future<String?> getPendingEmail();

  Future<void> clearPendingEmail();
}

@Singleton(as: MagicLinkEmailLocalDataSource)
class MagicLinkEmailLocalDataSourceImpl implements MagicLinkEmailLocalDataSource {
  static const String _nameBox = HiveConstantsForBoxes.magicLinkPendingEmail;
  static const String _emailKey = HiveConstantsForBoxes.defaultKey;
  static const String _savedAtKey = 'savedAt';
  static const Duration pendingEmailTtl = Duration(hours: 1);

  @override
  Future<void> savePendingEmail(String email) async {
    await HiveService.save<String>(_nameBox, _emailKey, email);
    await HiveService.save<String>(
      _nameBox,
      _savedAtKey,
      DateTime.now().toUtc().toIso8601String(),
    );
  }

  @override
  Future<String?> getPendingEmail() async {
    final email = await HiveService.get<String>(_nameBox, _emailKey);
    if (email == null || email.isEmpty) return null;

    final savedAtRaw = await HiveService.get<String>(_nameBox, _savedAtKey);
    if (savedAtRaw == null) {
      // Legacy entry without TTL — refresh timestamp so it remains usable once.
      await HiveService.save<String>(
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
    await HiveService.clear<String>(_nameBox);
  }
}
