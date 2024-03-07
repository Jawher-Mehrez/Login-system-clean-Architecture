// lib/domain/repositories/auth_repository_interface.dart

import 'package:trafic_gesture/shared/infrastructure/either.dart';
import 'package:trafic_gesture/shared/infrastructure/exceptions/http_exception.dart';

import '../entities/user.dart';

abstract class AuthRepositoryInterface {
Future<Either<AppException, User>>  login(String email, String password);
}
