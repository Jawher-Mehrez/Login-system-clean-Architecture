import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_providers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

final checkboxStateProvider = StateProvider<bool>((ref) => false);

// ignore: must_be_immutable
class InputFieldWidget extends ConsumerWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;

  // List<String?> _savedEmails = []; // List to hold saved emails
  InputFieldWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void loadSavedCredentials() async {
      final localStorageDataSource =
          await ref.read(localStorageDataSourceProvider);
      final savedEmail = await localStorageDataSource.getEmail();
      final savedPassword = await localStorageDataSource.getPassword();

      _usernameController.text = savedEmail ?? '';
      _passwordController.text = savedPassword ?? '';
    }

    // useEffect(() {
    //   loadSavedCredentials();
    //   return null;
    // }, []);

    final _isTrue = ref.watch(checkboxStateProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        TextFormField(
          controller: _usernameController,
          onTap: () => loadSavedCredentials(),
          decoration: InputDecoration(
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.white, fontSize: 16),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.white,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          ),
          style: TextStyle(color: Colors.white),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }

            final emailRegex = RegExp(
                r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})(\s*)$');

            if (!emailRegex.hasMatch(value)) {
              return 'Please enter a valid email address';
            }

            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _passwordController,
          // onTap: () => loadSavedCredentials(),
          obscureText: _isObscured,
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.white, fontSize: 16),
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            final username = _usernameController.text;
            final password = _passwordController.text;
            final authRepository = await ref.read(authRepositoryProvider);
            final loginSuccess = await authRepository.login(username, password);

            if (loginSuccess != null) {
              // Save credentials only when login is successful
              if (_isTrue) {
                final localStorageDataSource =
                    await ref.read(localStorageDataSourceProvider);
                await localStorageDataSource.saveEmail(username);
                await localStorageDataSource.savePassword(password);

                final saveloginemail = await localStorageDataSource.getEmail();
                final savepasslogin =
                    await localStorageDataSource.getPassword();

                print('savepasslogin: $savepasslogin');
                print('saveloginemail: $saveloginemail');
              }

              final usernameBeforeAt = username.split('@')[0];
              AwesomeDialogue.showSuccessDialog(context, usernameBeforeAt);
              // Reset the state of the checkbox to false after successful login
              ref.read(checkboxStateProvider.notifier).state = false;
            } else {
              ErrorDialogue.showErrorDialog(context);
              // Reset the state of the checkbox to false after successful login
              ref.read(checkboxStateProvider.notifier).state = false;
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:Color(0xFF22BA8E),   
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
            "Login",
            style: TextStyle(
              fontSize: screenWidth * 0.045,
            ),
          ),
        ),
        SizedBox(height: 20),
        // Adding ToggleButton here
        Center(
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center, // Center the children vertically
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0), // Add padding for spacing
                child: Text(
                  'Remember Me ',
                  style: TextStyle(
                    color: _isTrue
                        ? const Color.fromARGB(255, 105, 244, 109)
                        : Colors.white, // Change color based on _isTrue value
                    fontSize: 16, // Text size
                    fontWeight: FontWeight.bold, // Add a bit of emphasis
                  ),
                ),
              ),
              // Checkbox(
              //   value: _isTrue,
              //   onChanged: (newValue) async {
              //     ref.read(checkboxStateProvider.notifier).state = newValue!;
              //     if (newValue == true) {
              //       final localStorageDataSource =
              //           await ref.read(localStorageDataSourceProvider);
              //       await localStorageDataSource
              //           .saveEmail(_usernameController.text);
              //       await localStorageDataSource
              //           .savePassword(_passwordController.text);

              //       final saveloginemail =
              //           await localStorageDataSource.getEmail();
              //       final savepasslogin =
              //           await localStorageDataSource.getPassword();

              //       print('savepasslogin: $savepasslogin');
              //       print('saveloginemail: $saveloginemail');
              //     }
              //   },
              // ),
              Checkbox(
                value: _isTrue,
                onChanged: (newValue) {
                  ref.read(checkboxStateProvider.notifier).state = newValue!;
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class AwesomeDialogue {
  static void showSuccessDialog(BuildContext context, String usernameBeforeAt) {
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
      title: 'Login Failed',
      desc: 'Invalid username or password.',
    ).show();
  }
}
