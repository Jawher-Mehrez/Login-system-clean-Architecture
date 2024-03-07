import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_providers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

final checkboxStateProvider = StateProvider<bool>((ref) => false);

class InputFieldWidget extends ConsumerWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;

  InputFieldWidget({Key? key});

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
            final loginResult = await authRepository.login(username, password);

            print('Login result: $loginResult'); // Add this line for debugging

            loginResult.fold(
              (error) {
                // Error occurred during login
                print('Error occurred: $error'); // Add this line for debugging
                ErrorDialogue.showErrorDialog(context);
                ref.read(checkboxStateProvider.notifier).state = false;
              },
              (user) async {
                // Login successful
                print('Login successful'); // Add this line for debugging

                final localStorageDataSource =
                    await ref.read(localStorageDataSourceProvider);
                await localStorageDataSource.saveEmail(username);
                await localStorageDataSource.savePassword(password);

                final savedEmail = await localStorageDataSource.getEmail();
                final savedPassword =
                    await localStorageDataSource.getPassword();

                print('Saved Email: $savedEmail');
                print('Saved Password: $savedPassword');

                final usernameBeforeAt = username.split('@')[0];
                AwesomeDialogue.showSuccessDialog(context, usernameBeforeAt);
                ref.read(checkboxStateProvider.notifier).state = false;
              },
            );
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
            "Login",
            style: TextStyle(
              fontSize: screenWidth * 0.045,
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width, // Set maximum width
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Remember Me ',
                      style: TextStyle(
                        color: _isTrue
                            ? const Color.fromARGB(255, 105, 244, 109)
                            : Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Checkbox(
                  value: _isTrue,
                  onChanged: (newValue) {
                    ref.read(checkboxStateProvider.notifier).state = newValue!;
                  },
                ),
              ],
            ),
          ),
        ),
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
