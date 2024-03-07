import 'package:trafic_gesture/shared/infrastructure/either.dart';
import 'package:trafic_gesture/shared/infrastructure/exceptions/http_exception.dart';

import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/AuthRepositoryInterface.dart';

class AuthRepository implements AuthRepositoryInterface {
  final AuthRemoteDataSource remoteDataSource;
  final LocalStorageDataSource localStorageDataSource;

  AuthRepository({
    required this.remoteDataSource,
    required this.localStorageDataSource,
  });

  @override
  Future<Either<AppException, User>> login(
    String email,
    String password,
  ) async {
    try {
      final loginResult = await remoteDataSource.login(email, password);

      return loginResult.fold(
        (left) {
          print('Error occurred during login: $left');
          return Left(left);
        },
        (right) {
          print('Received user data: $right');

          if (right is User) {
            final user = right;
            print('Received user object: $user');

            // Save email to local storage
            localStorageDataSource.saveEmail(user.email).then((_) {
              print('Email saved successfully');
            });

            return Right(user);
          } else if (right == null) {
            print('Received null or empty user data');
            return Left(
              AppException(
                message: 'Received null or empty user data',
                statusCode: 1,
                identifier: 'AuthRepository.login',
              ),
            );
          } else if (right is Map<String, dynamic>) {
            final userData = right;

            final user = User.fromJson(userData as Map<String, dynamic>);
            print('Converted user object: $user');

            // Save email to local storage
            localStorageDataSource.saveEmail(user.email).then((_) {
              print('Email saved successfully');
            });

            return Right(user);
          } else {
            return Left(
              AppException(
                message: 'Unexpected type of user data: ${right.runtimeType}',
                statusCode: 1,
                identifier: 'AuthRepository.login',
              ),
            );
          }
        },
      );
    } catch (e) {
      print('Error occurred during login: $e');
      return Left(
        AppException(
          message: 'Error occurred during login: $e',
          statusCode: 1,
          identifier: 'AuthRepository.login',
        ),
      );
    }
  }
}
