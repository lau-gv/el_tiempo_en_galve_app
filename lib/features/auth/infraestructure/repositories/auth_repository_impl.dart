import 'package:el_tiempo_en_galve_app/features/auth/infraestructure/datasources/auth_datasource_cognitoimpl.dart';

import '../../domain/domain.dart';

class AuthRespositoryImpl  extends AuthRespository {

  final AuthDataSource dataSource;

  AuthRespositoryImpl([AuthDataSource? dataSource]) : dataSource = dataSource ?? AuthDataSourceCognitoImpl();

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<void> register(String username, String email, String password) {
    return dataSource.register(username, email, password);
  }
  
}