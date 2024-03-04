import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl;

  AuthRemoteDataSource(this.baseUrl);

  Future<Map<String, dynamic>?> createUser(
    String firstName,
    String lastName,
    String email,
    String password,
    String dateBirth,
    String carNumber,
    String role,
  ) async {
    print('Email: $email');
    print('Password: $password');
    print('role: $role');
    print('lastName: $lastName');
    print('dateBirth: $dateBirth');
    print('carNumber: $carNumber');
    print('lastName: $lastName');
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'dateBirth': dateBirth,
        'carNumber': carNumber,
        'role': role,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);

      if (responseBody != null && responseBody is Map<String, dynamic>) {
        return responseBody;
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to create account');
    }
  }
}
