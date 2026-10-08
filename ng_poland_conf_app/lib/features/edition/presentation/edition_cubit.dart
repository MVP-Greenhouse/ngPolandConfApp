import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ng_poland_conf_app/features/edition/datasources/repositories/edition_repository.dart';
import 'package:ng_poland_conf_app/features/edition/domains/entities/edition.dart';

sealed class EditionState {
  const EditionState();
}

class EditionInitial extends EditionState {
  const EditionInitial();
}

class EditionReady extends EditionState {
  const EditionReady(this.edition);

  final Edition edition;
}

class EditionFailed extends EditionState {
  const EditionFailed();
}

@singleton
class EditionCubit extends Cubit<EditionState> {
  EditionCubit(this._repository) : super(const EditionInitial());

  final EditionRepository _repository;

  Edition? get current => switch (state) {
    EditionReady(:final edition) => edition,
    _ => null,
  };

  Future<Edition?> ensure() async {
    final edition = await _repository.load();
    if (isClosed) return edition;
    if (edition == null) {
      emit(const EditionFailed());
      return null;
    }
    emit(EditionReady(edition));
    return edition;
  }
}
