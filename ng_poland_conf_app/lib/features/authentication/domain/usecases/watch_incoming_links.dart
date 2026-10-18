import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/authentication/domain/repositories/incoming_links_repository.dart';

/// The link the app was launched with (if any), followed by later links.
@injectable
class WatchIncomingLinks implements NoParamsStreamUseCase<Uri> {
  const WatchIncomingLinks(this._links);

  final IncomingLinksRepository _links;

  @override
  Stream<Uri> call() async* {
    if (await _links.initialLink() case final initial?) yield initial;
    yield* _links.links;
  }
}
