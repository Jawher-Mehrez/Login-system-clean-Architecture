// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:trafic_gesture/features/login/presentation/widgets/loginpage.dart';
// import 'package:trafic_gesture/features/sign_up/presentation/widgets/create_account.dart';

// void main() {
//   runApp(
//     const ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }

// ////lotties map:https://lottie.host/52147373-0b9b-4e1c-810b-b4d2fd071c2d/1lFl3swH05.json
// ///lotties amp:https://lottie.host/04b8e6cd-da1f-4b8d-84b8-e2e206685f23/BqqpItJfm9.json
// ///lottie :https://lottie.host/5b4ac47d-7f6b-453a-a00d-34fe210081ac/TeRAx2YPhk.json
// /////lottie work travaux:https://lottie.host/0f0762cf-173c-4e56-a625-9f703582d435/GTb2Kxmvet.json
// /////lottie accident:https://lottie.host/0f0762cf-173c-4e56-a625-9f703582d435/GTb2Kxmvet.json
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         // brightness: Brightness.dark, // Set brightness to dark     scaffoldBackgroundColor: Color(0xFF03084C),
//         scaffoldBackgroundColor:
//             Color(0xFF03084C), // Brown background color  00065A

//         // primaryColor:    Color.fromARGB(255, 59, 17, 65), // Custom primary color
//         // useMaterial3: true,
//       ),
//       home: const LoginPage(),
//           //  home: const CreateAccount(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trafic_gesture/features/login/presentation/widgets/loginpage.dart';
import 'package:trafic_gesture/features/sign_up/presentation/widgets/create_account.dart';
import 'package:trafic_gesture/features/userprofil.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF04253A),
      ),
      initialRoute: '/login', // Set the initial route
      routes: {
        '/login': (context) => const LoginPage(), // Define the '/login' route
        '/signup': (context) =>
            const CreateAccount(), // Define the '/signup' route
        // Add more routes as needed
      '/UserProfilePage': (context) =>
            const UserProfilePage(), // Define the '/signup' route
      },
    );
  }
}
// 0xFFf43868 rose 