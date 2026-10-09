part of 'edition_cubit.dart';

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
