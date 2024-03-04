import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final checkboxStateProvider = StateProvider<bool>((ref) => false);

class MyCheckboxWidget extends ConsumerWidget {
  const MyCheckboxWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool checkboxState = ref.watch(checkboxStateProvider.notifier).state;

    return Checkbox(
      value: checkboxState,
      onChanged: (newValue) {
        ref.read(checkboxStateProvider.notifier).state = newValue ?? false;
      },
      checkColor: Colors.white,
    );
  }
}
