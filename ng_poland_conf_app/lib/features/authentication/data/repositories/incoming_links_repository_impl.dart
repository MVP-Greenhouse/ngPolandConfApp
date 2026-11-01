import 'package:app_links/app_links.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/incoming_links_repository.dart';

@LazySingleton(as: IncomingLinksRepository)
class IncomingLinksRepositoryImpl implements IncomingLinksRepository {
  const IncomingLinksRepositoryImpl(this._appLinks, this._logger);

  final AppLinks _appLinks;
  final Logger _logger;

  @override
  Future<Uri?> initialLink() async {
    try {
      return await _appLinks.getInitialLink();
    } on Exception catch (error, stackTrace) {
      _logger.w(
        'Deep links: reading initial link failed',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  @override
  Stream<Uri> get links => _appLinks.uriLinkStream.handleError(
    (Object error, StackTrace stackTrace) => _logger.w(
      'Deep links: stream error',
      error: error,
      stackTrace: stackTrace,
    ),
  );
}
