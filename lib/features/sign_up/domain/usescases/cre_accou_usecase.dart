// // lib/domain/use_cases/create_account_use_case.dart

// import 'package:trafic_gesture/features/sign_up/domain/entities/user.dart';
// import 'package:trafic_gesture/features/sign_up/domain/repositories/user_repository_create.dart';

// class CreateAccountUseCase {
//   final UserRepository _userRepository;

//   CreateAccountUseCase(this._userRepository);

//   Future<void> execute(UserEntity user) async {
//     try {
//       // Add any business logic here, such as validation before creating a user

//       await _userRepository.createUser(user);
//     } catch (e) {
//       // Handle any errors, such as validation errors or repository failures
//       throw e;
//     }
//   }
// }
