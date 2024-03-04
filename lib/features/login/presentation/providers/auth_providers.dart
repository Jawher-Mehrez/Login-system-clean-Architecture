import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  const baseUrl =
      'http://10.0.2.2:3000/api/auth'; // Replace with your API base URL
  return AuthRemoteDataSource(baseUrl);
});

final authRepositoryProvider = Provider((ref) async {
  final localDataSource = await ref.watch(localStorageDataSourceProvider);
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepository(
    localStorageDataSource: localDataSource,
    remoteDataSource: remoteDataSource,
  );
});
