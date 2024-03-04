import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl;

  AuthRemoteDataSource(this.baseUrl);

  Future<Map<String, dynamic>?> login(String email, String password) async {
    print('Email: $email');
    print('Password: $password');
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
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
      throw Exception('Failed to login');
    }
  }
}
