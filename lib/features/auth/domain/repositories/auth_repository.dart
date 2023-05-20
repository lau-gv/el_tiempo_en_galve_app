import '../entities/user.dart';

abstract class AuthRespository {
  Future<User> login(String email, String password);
  Future<User> register(String username, String email, String password);
  Future<User> checkAuthStatus(String token);
}