import 'package:trafic_gesture/features/login/domain/entities/user.dart';
import 'package:trafic_gesture/shared/infrastructure/either.dart';
import 'package:trafic_gesture/shared/infrastructure/exceptions/http_exception.dart';
import 'package:trafic_gesture/shared/infrastructure/network_service.dart';

class AuthRemoteDataSource {
  final NetworkService networkService;

  AuthRemoteDataSource(this.networkService);

  Future<Either<AppException, User>> login(String email, String password) async {
    print('Email: $email');
    print('Password: $password');

    try {
      final eitherType = await networkService.post('/login', data: {
        'email': email,
        'password': password,
      });

      return eitherType.fold(
        (exception) {
          // Return the exception wrapped in a Left side of Either
          return Left(exception);
        },
        (response) {
          // Parse the response data into a User object
          final user = User.fromJson(response.data);
          // Update the token for requests
          networkService.updateHeader({'Authorization': user.token});
          // Return the user wrapped in a Right side of Either
          return Right(user);
        },
      );
    } catch (e) {
      // Return the caught exception wrapped in a Left side of Either
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nAuthRemoteDataSource.login',
        ),
      );
    }
  }
}
