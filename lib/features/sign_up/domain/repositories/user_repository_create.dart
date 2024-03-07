

import 'package:trafic_gesture/shared/infrastructure/either.dart';
import 'package:trafic_gesture/shared/infrastructure/exceptions/http_exception.dart';

import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<AppException, User>> createUser(
  User user
  );
}
