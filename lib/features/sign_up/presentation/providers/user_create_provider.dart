import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trafic_gesture/features/sign_up/data/datasources/auth_remote_create.dart';
import 'package:trafic_gesture/features/sign_up/data/repositories/reositiry_cre_impl.dart';
import 'package:trafic_gesture/features/sign_up/domain/repositories/user_repository_create.dart';
import 'package:trafic_gesture/shared/infrastructure/providers/network_service_provider.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final networkService = ref.read(networkServiceProvider);
  return AuthRemoteDataSource(networkService);
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final remoteDataSource = ref.read(authRemoteDataSourceProvider);
  return UserRepositoryImplement(remoteDataSource);
});
