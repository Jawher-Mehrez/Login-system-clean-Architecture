class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String dateBirth;
  final String carNumber;
  final String role;
  final String token;

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
  });

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
