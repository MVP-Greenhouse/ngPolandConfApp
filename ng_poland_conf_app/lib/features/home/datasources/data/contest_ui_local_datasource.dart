import 'package:hive_ce/hive.dart';
import 'package:injectable/injectable.dart';

@injectable
class ContestUiLocalDataSource {
  Future<Box<bool>> _box() => Hive.openBox<bool>('contest_ui');

  Future<bool> wasWinDialogShown(String contestId) async {
    final box = await _box();
    return box.get('winDialogShown_$contestId') ?? false;
  }

  Future<void> markWinDialogShown(String contestId) async {
    final box = await _box();
    await box.put('winDialogShown_$contestId', true);
  }
}
