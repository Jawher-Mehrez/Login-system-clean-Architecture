import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trafic_gesture/features/sign_up/data/datasources/auth_remote_create.dart';
import 'package:trafic_gesture/features/sign_up/data/repositories/reositiry_cre_impl.dart';
import 'package:trafic_gesture/features/sign_up/domain/repositories/user_repository_create.dart';

// Provider for AuthRemoteDataSource
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  const baseUrl =
      'http://10.0.2.2:3000/api/auth'; // Replace with your API base URL
  return AuthRemoteDataSource(baseUrl);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remoteDataSource = ref.read(authRemoteDataSourceProvider);
  return UserRepositoryImplement(remoteDataSource);
});
