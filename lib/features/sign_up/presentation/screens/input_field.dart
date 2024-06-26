// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// import 'package:trafic_gesture/features/sign_up/domain/entities/user.dart';

// import 'package:trafic_gesture/features/sign_up/presentation/providers/user_create_provider.dart';

// void main() async {
//   // Initialize Hive for Flutter
//   await Hive.initFlutter();
//   Hive.registerAdapter(UserAdapter());

//   // Open the Hive box containing user data
//   await Hive.openBox<User>('users');
// }

// class InputFieldWidget extends ConsumerWidget {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _dateBirthController = TextEditingController();
//   final TextEditingController _carNumberController = TextEditingController();
//   final TextEditingController _roleController = TextEditingController();
//   bool _isObscured = true;

//   InputFieldWidget({Key? key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 18.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 15),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: _firstNameController,
//                     decoration: InputDecoration(
//                       hintText: "First Name",
//                       hintStyle: TextStyle(color: Colors.white, fontSize: 12),
//                       prefixIcon: Icon(
//                         Icons.person,
//                         color: Colors.white,
//                       ),
//                       contentPadding: EdgeInsets.symmetric(vertical: 12),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                     ),
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your first name';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: TextFormField(
//                     controller: _lastNameController,
//                     decoration: InputDecoration(
//                       hintText: "Last Name",
//                       hintStyle: TextStyle(color: Colors.white, fontSize: 12),
//                       prefixIcon: Icon(
//                         Icons.person,
//                         color: Colors.white,
//                       ),
//                       contentPadding: EdgeInsets.symmetric(vertical: 12),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide(color: Colors.white),
//                       ),
//                     ),
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your last name';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 hintText: "Email",
//                 hintStyle: TextStyle(color: Colors.white, fontSize: 12),
//                 prefixIcon: Icon(
//                   Icons.email,
//                   color: Colors.white,
//                 ),
//                 contentPadding: EdgeInsets.symmetric(vertical: 12),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//               ),
//               style: TextStyle(color: Colors.white, fontSize: 12),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your email';
//                 }
//                 if (!EmailValidator.validate(value)) {
//                   return 'Please enter a valid email address';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: _isObscured,
//               decoration: InputDecoration(
//                 hintText: "Password",
//                 hintStyle: TextStyle(color: Colors.white, fontSize: 12),
//                 prefixIcon: Icon(
//                   Icons.lock,
//                   color: Colors.white,
//                 ),
//                 suffixIcon: IconButton(
//                   onPressed: () {
//                     _isObscured = !_isObscured;
//                   },
//                   icon: Icon(
//                     _isObscured ? Icons.visibility : Icons.visibility_off,
//                     color: Colors.white,
//                   ),
//                 ),
//                 contentPadding: EdgeInsets.symmetric(vertical: 12),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//               ),
//               style: TextStyle(color: Colors.white, fontSize: 12),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your password';
//                 }
//                 if (value.length < 6) {
//                   return 'Password must be at least 6 characters long';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: _dateBirthController,
//               decoration: InputDecoration(
//                 hintText: "Date of Birth",
//                 hintStyle: TextStyle(color: Colors.white, fontSize: 12),
//                 prefixIcon: Icon(
//                   Icons.calendar_today,
//                   color: Colors.white,
//                 ),
//                 contentPadding: EdgeInsets.symmetric(vertical: 12),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//               ),
//               style: TextStyle(color: Colors.white, fontSize: 12),
//               validator: (value) {
//                 final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your date of birth';
//                 }
//                 if (!dateRegex.hasMatch(value)) {
//                   return 'Please enter a valid date in the format YYYY-MM-DD';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: _carNumberController,
//               decoration: InputDecoration(
//                 hintText: "Car Number",
//                 hintStyle: TextStyle(color: Colors.white, fontSize: 12),
//                 prefixIcon: Icon(
//                   Icons.directions_car,
//                   color: Colors.white,
//                 ),
//                 contentPadding: EdgeInsets.symmetric(vertical: 12),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//               ),
//               style: TextStyle(color: Colors.white, fontSize: 12),
//               validator: (value) {
//                 // Add validation logic if needed
//                 return null;
//               },
//             ),
//             SizedBox(height: 10),
//             TextFormField(
//               controller: _roleController,
//               decoration: InputDecoration(
//                 hintText: "Role",
//                 hintStyle: TextStyle(color: Colors.white, fontSize: 12),
//                 prefixIcon: Icon(
//                   Icons.person_outline,
//                   color: Colors.white,
//                 ),
//                 contentPadding: EdgeInsets.symmetric(vertical: 12),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.white),
//                 ),
//               ),
//               style: TextStyle(color: Colors.white, fontSize: 12),
//               validator: (value) {
//                 // Add validation logic if needed
//                 return null;
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   final user = User(
//                     firstName: _firstNameController.text,
//                     lastName: _lastNameController.text,
//                     email: _emailController.text,
//                     password: _passwordController.text,
//                     dateBirth: _dateBirthController.text,
//                     carNumber: _carNumberController.text,
//                     role: _roleController.text,
//                   );

//                   final createAccount = ref.read(userRepositoryProvider);

//                   final result = await createAccount.createUser(user);

//                   result.fold(
//                     (error) {
//                       // Handle error case
//                       ErrorDialogue.showErrorDialog(context);
//                     },
//                     (user) async {
//                       // Future<void> saveUserToHive() async {
//                       //   final user = User(
//                       //     firstName: _firstNameController.text,
//                       //     lastName: _lastNameController.text,
//                       //     email: _emailController.text,
//                       //     password: _passwordController.text,
//                       //     dateBirth: _dateBirthController.text,
//                       //     carNumber: _carNumberController.text,
//                       //     role: _roleController.text,
//                       //   );

//                       //   final userBox = await Hive.openBox<User>('users');
//                       //   await userBox.put('user', user);
//                       // }

//                       // Future<void> _printUserBoxContents() async {
//                       //   final userBox = await Hive.openBox<User>('users');
//                       //   print('Printing user box contents:');
//                       //   print(userBox.values);
//                       // } // Handle success casendle success case

//                       // Initialize Hive for Flutter
//                       await Hive.initFlutter();

// // Register the adapter for the User class
//                       Hive.registerAdapter(UserAdapter());

// // Open the Hive box containing user data
//                       final userBox = await Hive.openBox<User>('users');

// // Instantiate the User object
//                       final user = User(
//                         firstName: _firstNameController.text,
//                         lastName: _lastNameController.text,
//                         email: _emailController.text,
//                         password: _passwordController.text,
//                         dateBirth: _dateBirthController.text,
//                         carNumber: _carNumberController.text,
//                         role: _roleController.text,
//                       );

// // Store the User object in the Hive box
//                       await userBox.put('user1', user);

// // Retrieve the stored User object from the Hive box
// final storedUser = userBox.get('user1');
// print('Stored User: $storedUser'); // Print the retrieved user

//                       print(
//                           'Stored Uservvvvvvvv: $storedUser'); // Print the retrieved user

//                       final usernameBeforeAt = user.email.split('@')[0];
//                       AwesomeDialogue.showSuccessDialog(
//                           context, usernameBeforeAt);
//                     },
//                   );
//                 } catch (e) {
//                   // Handle generic error
//                   ErrorDialogue.showErrorDialog(context);
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF22BA8E),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 child: Text(
//                   "Create Account",
//                   style: TextStyle(
//                     fontSize: 12,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             InkWell(
//               onTap: () {
//                 Navigator.of(context).pushReplacementNamed('/login');
//               },
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       "Already have an account?   ",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                   Flexible(
//                     child: Text(
//                       "Login here",
//                       style: TextStyle(
//                         color: Color(0xFF22BA8E),
//                         decoration: TextDecoration.underline,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AwesomeDialogue {
//   static void showSuccessDialog(BuildContext context, String usernameBeforeAt) {
//     print('Username before @: $usernameBeforeAt'); // Debugging
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.success,
//       animType: AnimType.topSlide,
//       title: 'Login Successful',
//       desc: 'Welcome $usernameBeforeAt! You are now logged in.',
//       btnOkText: 'OK',
//       btnOkOnPress: () {},
//     ).show();
//   }
// }

// class ErrorDialogue {
//   static void showErrorDialog(BuildContext context) {
//     AwesomeDialog(
//       context: context,
//       dialogType: DialogType.error,
//       title: 'Account Creation Failed',
//       desc: 'Failed to create the account. Please try again later.',
//       btnOkText: 'OK',
//       btnOkOnPress: () {},
//     ).show();
//   }
// }

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:trafic_gesture/features/sign_up/domain/entities/user.dart';

import 'package:trafic_gesture/features/sign_up/presentation/providers/user_create_provider.dart';

void main() async {
  // Initialize Hive for Flutter
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());

  // Open the Hive box containing user data
  await Hive.openBox<User>('users');
}

class InputFieldWidget extends ConsumerWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateBirthController = TextEditingController();
  final TextEditingController _carNumberController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  bool _isObscured = true;

  InputFieldWidget({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      hintText: "First Name",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 12),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 12),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.white, fontSize: 12),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white, fontSize: 12),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!EmailValidator.validate(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: _isObscured,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.white, fontSize: 12),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    _isObscured = !_isObscured;
                  },
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white, fontSize: 12),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _dateBirthController,
              decoration: InputDecoration(
                hintText: "Date of Birth",
                hintStyle: TextStyle(color: Colors.white, fontSize: 12),
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white, fontSize: 12),
              validator: (value) {
                final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                if (value == null || value.isEmpty) {
                  return 'Please enter your date of birth';
                }
                if (!dateRegex.hasMatch(value)) {
                  return 'Please enter a valid date in the format YYYY-MM-DD';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _carNumberController,
              decoration: InputDecoration(
                hintText: "Car Number",
                hintStyle: TextStyle(color: Colors.white, fontSize: 12),
                prefixIcon: Icon(
                  Icons.directions_car,
                  color: Colors.white,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white, fontSize: 12),
              validator: (value) {
                // Add validation logic if needed
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _roleController,
              decoration: InputDecoration(
                hintText: "Role",
                hintStyle: TextStyle(color: Colors.white, fontSize: 12),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white, fontSize: 12),
              validator: (value) {
                // Add validation logic if needed
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  final user = User(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                    dateBirth: _dateBirthController.text,
                    carNumber: _carNumberController.text,
                    role: _roleController.text,
                  );

                  final createAccount = ref.read(userRepositoryProvider);

                  final result = await createAccount.createUser(user);

                  result.fold(
                    (error) {
                      // Handle error case
                      ErrorDialogue.showErrorDialog(context);
                    },
                    (user) async {
                      // Future<void> saveUserToHive() async {
                      //   final user = User(
                      //     firstName: _firstNameController.text,
                      //     lastName: _lastNameController.text,
                      //     email: _emailController.text,
                      //     password: _passwordController.text,
                      //     dateBirth: _dateBirthController.text,
                      //     carNumber: _carNumberController.text,
                      //     role: _roleController.text,
                      //   );

                      //   final userBox = await Hive.openBox<User>('users');
                      //   await userBox.put('user', user);
                      // }

                      // Future<void> _printUserBoxContents() async {
                      //   final userBox = await Hive.openBox<User>('users');
                      //   print('Printing user box contents:');
                      //   print(userBox.values);
                      // } // Handle success casendle success case

                      // Initialize Hive for Flutter
                      await Hive.initFlutter();

// Register the adapter for the User class
                      Hive.registerAdapter(UserAdapter());

// Open the Hive box containing user data
                      final userBox = await Hive.openBox<User>('users');

// Instantiate the User object
                      final user = User(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        dateBirth: _dateBirthController.text,
                        carNumber: _carNumberController.text,
                        role: _roleController.text,
                      );

// Store the User object in the Hive box
                      await userBox.put('user1', user);

// Retrieve the stored User object from the Hive box
final storedUser = userBox.get('user1');
print('Stored User: $storedUser'); // Print the retrieved user

                      print(
                          'Stored Uservvvvvvvv: $storedUser'); // Print the retrieved user

                      final usernameBeforeAt = user.email.split('@')[0];
                      AwesomeDialogue.showSuccessDialog(
                          context, usernameBeforeAt);
                    },
                  );
                } catch (e) {
                  // Handle generic error
                  ErrorDialogue.showErrorDialog(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF22BA8E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Already have an account?   ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Login here",
                      style: TextStyle(
                        color: Color(0xFF22BA8E),
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AwesomeDialogue {
  static void showSuccessDialog(BuildContext context, String usernameBeforeAt) {
    print('Username before @: $usernameBeforeAt'); // Debugging
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.topSlide,
      title: 'Login Successful',
      desc: 'Welcome $usernameBeforeAt! You are now logged in.',
      btnOkText: 'OK',
      btnOkOnPress: () {},
    ).show();
  }
}

class ErrorDialogue {
  static void showErrorDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      title: 'Account Creation Failed',
      desc: 'Failed to create the account. Please try again later.',
      btnOkText: 'OK',
      btnOkOnPress: () {},
    ).show();
  }
}

