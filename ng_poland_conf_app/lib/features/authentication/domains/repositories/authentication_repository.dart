import 'package:dartz/dartz.dart';

abstract interface class AuthenticationRepository {
  Future<Either<String, String>> signInWithGoogle();

  Future<Either<String, String>> signInWithApple();
}
