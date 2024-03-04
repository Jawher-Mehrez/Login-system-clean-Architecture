import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PasswordToggleIcon extends ConsumerWidget {
  final bool isObscured;
  final VoidCallback onPressed;

  const PasswordToggleIcon({
    required this.isObscured,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isObscured ? Icons.visibility : Icons.visibility_off,
        color: Colors.white,
      ),
    );
  }
}
