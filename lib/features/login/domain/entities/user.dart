// import 'package:equatable/equatable.dart';

//hive locale storage eg keep logged in logoute
class User {
  final int id;
  final String role;
  final String password;
  final String email;
  final String firstName;
  final String lastName;
  final String dateBirth;
  final String carNumber;
  final String token;
  const User({
    this.id = 0,
    this.role = '',
    this.password = '',
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.dateBirth = '',
    this.carNumber = '',
    this.token = '',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'role': role,
      'password': password,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'dateBirth': dateBirth,
      'carNumber': carNumber,
      'token': token,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) => User(
        id: map['id'] ?? 0,
        role: map['role'] ?? '',
        password: map['password'] ?? '',
        email: map['email'] ?? '',
        firstName: map['firstName'] ?? '',
        lastName: map['lastName'] ?? '',
        dateBirth: map['dateBirth'] ?? '',
        carNumber: map['carNumber'] ?? '',
        token: map['token'] ?? '',
      );

  User copyWith({
    int? id,
    String? role,
    String? password,
    String? email,
    String? firstName,
    String? lastName,
    String? dateBirth,
    String? carNumber,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      role: role ?? this.role,
      password: password ?? this.password,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateBirth: dateBirth ?? this.dateBirth,
      carNumber: carNumber ?? this.carNumber,
      token: token ?? this.token,
    );
  }
}
