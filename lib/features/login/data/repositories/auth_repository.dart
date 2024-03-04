import 'package:shared_preferences/shared_preferences.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/AuthRepositoryInterface.dart';

class AuthRepository implements AuthRepositoryInterface {
  final AuthRemoteDataSource remoteDataSource;
  final LocalStorageDataSource localStorageDataSource; // Add this line
  AuthRepository({
    required this.remoteDataSource,
    required this.localStorageDataSource,
  });

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userData = await remoteDataSource.login(email, password);
      print('Received user data: $userData');

      if (userData != null) {
        final user = User.fromJson(userData);
        print('Converted user object: $user');

        print('Email from user object: ${user.email}');

        if (password.isNotEmpty) {
          // Save password to local storage only if it's not null or empty
          // await localStorageDataSource.savePassword(password);
          // print('Password saved successfully');
        } else {
          print('Password is null or empty, not saved');
        }

        // // Save email to local storage
        // await localStorageDataSource.saveEmail(user.email);
        // print('Email saved successfully');

        // // Verify email and password were saved correctly
        // final sharedPreferences = await SharedPreferences.getInstance();
        // final savedEmail = sharedPreferences.getString('email');
        // print('Saved email: $savedEmail');

        // final savedPassword = sharedPreferences.getString('password');
        // print('Saved password: $savedPassword');

        return user;
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
