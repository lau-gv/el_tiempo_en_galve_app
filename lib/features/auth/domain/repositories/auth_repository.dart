import '../entities/user.dart';

abstract class AuthRespository {
  Future<User> login(String email, String password);
  Future<void> register(String username, String email, String password);
  Future<bool> confirmEmail(String username, String numberConfirm);
}