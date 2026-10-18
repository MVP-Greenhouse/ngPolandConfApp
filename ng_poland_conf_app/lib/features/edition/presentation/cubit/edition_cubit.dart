import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ng_poland_conf_app/features/edition/domain/entities/edition.dart';
import 'package:ng_poland_conf_app/features/edition/domain/exceptions/edition_unavailable_exception.dart';
import 'package:ng_poland_conf_app/features/edition/domain/usecases/get_edition.dart';

part 'edition_state.dart';

/// App-wide holder of the current edition, provided above the router.
@singleton
class EditionCubit extends Cubit<EditionState> {
  EditionCubit(this._getEdition, this._logger) : super(const EditionInitial());

  final GetEdition _getEdition;
  final Logger _logger;

  Edition? get current => switch (state) {
    EditionReady(:final edition) => edition,
    _ => null,
  };

  Future<void> load() async {
    try {
      final edition = await _getEdition();
      if (!isClosed) emit(EditionReady(edition));
    } on EditionUnavailableException catch (error, stackTrace) {
      _logger.w('Edition unavailable', error: error, stackTrace: stackTrace);
      if (!isClosed) emit(const EditionFailed());
    }
  }
}
