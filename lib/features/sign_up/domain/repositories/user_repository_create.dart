abstract class UserRepository {
  Future<void> createUser(
    String firstName,
    String lastName,
    String email,
    String password,
    String dateBirth,
    String carNumber,
    String role,
  );
}
