

import 'package:trafic_gesture/features/sign_up/domain/entities/user.dart';
import 'package:trafic_gesture/shared/infrastructure/either.dart';
import 'package:trafic_gesture/shared/infrastructure/exceptions/http_exception.dart';
import 'package:trafic_gesture/shared/infrastructure/network_service.dart';

class AuthRemoteDataSource {
  final NetworkService networkService;

  AuthRemoteDataSource(this.networkService);

  Future<Either<AppException, User>> createUser(
    User user,
  ) async {
    try {
final response = await networkService.post(
  '/register',
  data: user.toJson(),
);

return response.fold(
  (exception) {
    // Return the exception wrapped in a Left side of Either
    return Left(exception);
  },
  (response) {
    try {
      final Map<String, dynamic> jsonResponse = response.data;
      final user = User.fromJson(jsonResponse);
      networkService.updateHeader({'Authorization': user.token});
      return Right(user);
    } catch (e) {
      return Left(
        AppException(
          message: 'Failed to parse response data: $e',
          statusCode: -1,
          identifier: 'AuthRemoteDataSource.createUser',
        ),
      );
    }
  },
);

    } catch (e) {
      return Left(
        AppException(
          message: 'Failed to create account: $e',
          statusCode: -1,
          identifier: 'AuthRemoteDataSource.createUser',
        ),
      );
    }
  }
}
