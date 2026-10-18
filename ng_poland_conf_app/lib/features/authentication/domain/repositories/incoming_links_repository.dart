/// Deep links the app was opened with or receives while running.
abstract interface class IncomingLinksRepository {
  Future<Uri?> initialLink();

  Stream<Uri> get links;
}
