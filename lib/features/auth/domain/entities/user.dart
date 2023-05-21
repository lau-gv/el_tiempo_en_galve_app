class User {
  final String _id;
  final String _email;
  final String _username;
  //Esto es horrible pero se buscará una mejora a futuro.
  final String _password;
  final String _token;

 User({
    required String id,
    required String email,
    required String username,
    required String password,
    required String token,
  })  : _id = id,
        _email = email,
        _username = username,
        _password = password,
        _token = token;

  String get id => _id;
  String get email => _email;
  String get username => _username;
  String get password => _password;
  String get token => _token;
}
