class UnauthenticateUser {
  final String _email;
  final String _username;
  final String _password;

 UnauthenticateUser({
    required String email,
    required String username,
    required String password,
  })  : _email = email,
        _username = username,
        _password = password;

  String get email => _email;
  String get username => _username;
  String get password => _password;
}
