abstract interface class ConnectivityRepository {
  /// Emits the current online state, then every change.
  Stream<bool> watchOnline();
}
