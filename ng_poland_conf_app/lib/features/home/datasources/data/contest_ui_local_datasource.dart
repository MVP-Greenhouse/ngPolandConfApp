import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

@injectable
class ContestUiLocalDataSource {
  Future<Box<bool>> _box() => Hive.openBox<bool>('contest_ui');

  Future<bool> wasWinDialogShown(String confId) async {
    final box = await _box();
    return box.get('winDialogShown_$confId') ?? false;
  }

  Future<void> markWinDialogShown(String confId) async {
    final box = await _box();
    await box.put('winDialogShown_$confId', true);
  }
}
