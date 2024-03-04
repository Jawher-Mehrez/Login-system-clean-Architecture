import 'package:trafic_gesture/features/sign_up/data/datasources/auth_remote_create.dart';
import 'package:trafic_gesture/features/sign_up/domain/entities/user.dart';
import 'package:trafic_gesture/features/sign_up/domain/repositories/user_repository_create.dart';

class UserRepositoryImplement extends UserRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  UserRepositoryImplement(this.authRemoteDataSource);

  @override
  Future<void> createUser(
    String firstName,
    String lastName,
    String email,
    String password,
    String dateBirth,
    String carNumber,
    String role,
  ) async {
    try {
      final userData = await authRemoteDataSource.createUser(
          firstName, lastName, email, password, dateBirth, carNumber, role);

      print('Received user data: $userData');
      print('Received user data: $userData');

      print('Received user data: $userData');

      if (userData != null) {
        final user = User.fromJson(userData);
        print('Converted user object: $user');

        print('Email from user object: ${user.email}');
        // return user;
      } else {
        // Handle null response from remote data source
        print('Received null user data');
        return null;
      }
    } catch (e) {
      // Handle exceptions
      print('Login failed: $e');
      return null;
    }
  }
}
