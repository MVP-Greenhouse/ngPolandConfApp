import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/core/domain/use_case.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domain/repositories/edition_repository.dart';

@injectable
class GetEdition implements NoParamsUseCase<Edition> {
  const GetEdition(this._repository);

  final EditionRepository _repository;

  @override
  Future<Edition> call() => _repository.load();
}
