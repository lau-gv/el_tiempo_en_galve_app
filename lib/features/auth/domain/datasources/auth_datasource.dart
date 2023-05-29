import '../entities/user.dart';

abstract class AuthDataSource {
  Future<User> login(String email, String password);
  Future<void> register(String username, String email, String password);
}