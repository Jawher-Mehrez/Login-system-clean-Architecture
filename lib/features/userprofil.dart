import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trafic_gesture/features/sign_up/domain/entities/user.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: FutureBuilder(
        future: _getUserData(),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'User Profile',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text('First Name: ${user.firstName}'),
                  Text('Last Name: ${user.lastName}'),
                  Text('Email: ${user.email}'),
                  Text('Date of Birth: ${user.dateBirth}'),
                  Text('Car Number: ${user.carNumber}'),
                  Text('Role: ${user.role}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<User> _getUserData() async {
    await Hive.initFlutter();

    // Check if the adapter is already registered
    if (!Hive.isAdapterRegistered(UserAdapter().typeId)) {
      Hive.registerAdapter(UserAdapter());
    }

    // Open the Hive box containing user data
    await Hive.openBox<User>('users');

    // Retrieve and display the user data
    final userBox = Hive.box<User>('users');
    final user = userBox.get('user1');

    if (user == null) {
      throw Exception('User data not found in Hive');
    }

    print(user);
    return user;
  }
}
