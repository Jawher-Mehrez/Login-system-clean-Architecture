import 'package:hive/hive.dart';
import 'package:trafic_gesture/features/sign_up/data/datasources/auth_remote_create.dart';
import 'package:trafic_gesture/features/sign_up/domain/entities/user.dart';
import 'package:trafic_gesture/features/sign_up/domain/repositories/user_repository_create.dart';

import 'package:trafic_gesture/shared/infrastructure/exceptions/http_exception.dart';
import 'package:trafic_gesture/shared/infrastructure/either.dart';

class UserRepositoryImplement implements UserRepository {
  final AuthRemoteDataSource remoteDataSource;

  UserRepositoryImplement(this.remoteDataSource);
  @override
  Future<Either<AppException, User>> createUser(User user) async {
    try {
      final createUserResult = await remoteDataSource.createUser(user);

      return createUserResult.fold(
        (left) {
          // Handle error case
          print('Error occurred during user creation: $left');
          return Left(left);
        },
        (right) async {
          // Handle success case
          print('Received user data: $right');

          if (right is User) {
            print('Received user object: $right');
            print('Email from user object: ${right.email}');
            // Save user to Hive

            return Right(right);
          } else {
            // Handle unexpected response from remote data source
            print('Received unexpected user data: $right');
            return Left(
              AppException(
                message: 'Received unexpected user data: $right',
                statusCode: 1,
                identifier: 'UserRepository.createUser',
              ),
            );
          }
        },
      );
    } catch (e) {
      // Handle generic error
      print('User creation failed: $e');
      return Left(
        AppException(
          message: 'User creation failed: $e',
          statusCode: 1,
          identifier: 'UserRepository.createUser',
        ),
      );
    }
  }
}
