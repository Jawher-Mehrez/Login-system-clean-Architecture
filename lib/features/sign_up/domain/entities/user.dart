import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  static int _lastAssignedId = 0;

  @HiveField(0)
  int id;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String email;

  @HiveField(4)
  String password;

  @HiveField(5)
  String dateBirth;

  @HiveField(6)
  String carNumber;

  @HiveField(7)
  String role;

  @HiveField(8)
  String token;

  User({
    this.id = 0,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.dateBirth = '',
    this.carNumber = '',
    this.role = '',
    this.token = '',
  }) {
    // Increment the last assigned ID and assign it to the current instance
    id = ++_lastAssignedId;
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      dateBirth: _parseDate(map['dateBirth'] ?? ''),
      carNumber: map['carNumber'] ?? '',
      role: map['role'] ?? '',
      token: map['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'dateBirth': dateBirth,
      'carNumber': carNumber,
      'role': role,
      'token': token,
    };
  }

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? dateBirth,
    String? carNumber,
    String? role,
    String? token,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      dateBirth: dateBirth ?? this.dateBirth,
      carNumber: carNumber ?? this.carNumber,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }

  static String _parseDate(String dateString) {
    try {
      // Parse date string into a DateTime object
      DateTime dateTime = DateTime.parse(dateString);

      // Format the DateTime object to contain only the date portion
      return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    } catch (e) {
      // Return original string if parsing fails
      return dateString;
    }
  }
}
