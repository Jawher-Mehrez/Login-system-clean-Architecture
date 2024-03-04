import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:trafic_gesture/features/sign_up/presentation/providers/user_create_provider.dart';

// ignore: must_be_immutable
class InputFieldWidget extends ConsumerWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateBirthController = TextEditingController();
  final TextEditingController _carNumberController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  bool _isObscured = true;

  InputFieldWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('_roleController.text: ${_roleController.text}');

    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: 20.0,
      ),
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
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
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
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
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
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
            ),
            style: TextStyle(color: Colors.white),
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
              hintStyle: TextStyle(color: Colors.white),
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
            ),
            style: TextStyle(color: Colors.white),
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
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
            ),
            style: TextStyle(color: Colors.white),
            validator: (value) {
              print('Entered date: $value');
              final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
              if (value == null || value.isEmpty) {
                print('Empty date value');
                return 'Please enter your date of birth';
              }
              if (!dateRegex.hasMatch(value)) {
                print('Invalid date format');
                return 'Please enter a valid date in the format YYYY-MM-DD';
              }
              print('Date is valid');
              return null; // Return null if the value is valid
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _carNumberController,
            decoration: InputDecoration(
              hintText: "Car Number",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.directions_car,
                color: Colors.white,
              ),
            ),
            style: TextStyle(color: Colors.white),
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
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
            ),
            style: TextStyle(color: Colors.white),
            validator: (value) {
              // Add validation logic if needed
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final firstName = _firstNameController.text;
              final lastName = _lastNameController.text;
              final email = _emailController.text;
              final password = _passwordController.text;
              final dateBirth = _dateBirthController.text;
              final carNumber = _carNumberController.text;
              final role = _roleController.text;

              final createAccountUseCase = ref.read(userRepositoryProvider);
              // final result = await createAccountUseCase.createUser(firstName,
              //     lastName, email, password, dateBirth, carNumber, role);

              // try {
              //   await createAccountUseCase.createUser(firstName, lastName,
              //       email, password, dateBirth, carNumber, role);
              //   AwesomeDialogue.showSuccessDialog(context, firstName);
              // } catch (e) {
              //   ErrorDialogue.showErrorDialog(context);
              // }

              try {
                await createAccountUseCase.createUser(firstName, lastName,
                    email, password, dateBirth, carNumber, role);
                AwesomeDialogue.showSuccessDialog(context, firstName);
              } catch (e) {
                ErrorDialogue.showErrorDialog(context);
              }

              // if (result ) {
              //     AwesomeDialogue.showSuccessDialog(context, user.firstName);
              //   } else {
              //     ErrorDialogue.showErrorDialog(context);
              //   }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF22BA8E),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.2,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Create Account",
              style: TextStyle(
                fontSize: screenWidth * 0.045,
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?   ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Login here",
                  style: TextStyle(
                    color: Color(0xFF22BA8E),
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AwesomeDialogue {
  static void showSuccessDialog(BuildContext context, String username) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.topSlide,
      title: 'Account Created',
      desc: 'Welcome $username! Your account has been created successfully.',
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
