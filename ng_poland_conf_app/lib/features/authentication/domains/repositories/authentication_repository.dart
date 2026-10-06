import 'package:dartz/dartz.dart';

abstract interface class AuthenticationRepository {
  Future<Either<String, String>> signInWithGoogle();

  Future<Either<String, String>> signInWithApple();

  Future<Either<String, String>> sendSignInLink(String email);

  Future<Either<String, String>> completeSignInWithEmailLink(String emailLink);
}
