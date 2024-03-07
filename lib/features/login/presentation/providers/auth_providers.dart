import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafic_gesture/shared/infrastructure/providers/network_service_provider.dart';
import '../../data/datasources/auth_local_data_source.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository.dart';

// Provider for asynchronously obtaining SharedPreferences instance
final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// final rememberMeProvider = StateProvider<bool>((ref) {
//   final sharedPreferences = ref.watch(sharedPreferencesProvider);
//   return sharedPreferences?.maybeWhen(
//         data: (sharedPrefs) => sharedPrefs.getBool('remember_me') ?? false,
//         orElse: () => false,
//       ) ??
//       false;
// });

// Provider for LocalStorageDataSource
final localStorageDataSourceProvider = Provider((ref) async {
  final sharedPreferences = await ref.watch(sharedPreferencesProvider.future);
  return LocalStorageDataSource(sharedPreferences);
});

// Provider for AuthRemoteDataSource
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final networkService = ref.read(networkServiceProvider);
  return AuthRemoteDataSource(networkService);
});

final authRepositoryProvider = Provider((ref) async {
  final localDataSource = await ref.watch(localStorageDataSourceProvider);
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepository(
    localStorageDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
  );
});
