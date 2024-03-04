import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'fogot_passsword.dart';
import 'header_login.dart';
import 'input_field.dart';
import 'sign_up.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const HeaderWidget(),
                const SizedBox(height: 20), // Add some spacing
                InputFieldWidget(),
                const SizedBox(height: 10), // Add some spacing
                const ForgotPasswordWidget(),
                const SizedBox(height: 20), // Add some spacing
                const SignUpWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
