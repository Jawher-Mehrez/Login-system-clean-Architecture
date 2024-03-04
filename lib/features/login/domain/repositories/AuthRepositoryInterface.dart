// lib/domain/repositories/auth_repository_interface.dart

import '../entities/user.dart';

abstract class AuthRepositoryInterface {
  Future<User?> login(String email, String password);
}
