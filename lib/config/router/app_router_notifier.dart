import 'package:el_tiempo_en_galve_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {

  final AuthNotifier _authNotifier;
  AuthStatus _authStatus = AuthStatus.checking;

  GoRouterNotifier(this._authNotifier) {
    //Necesitamos estar en todo momento de la aplicación, pendientes del authNotifier.
    //Cuando exista un cambio en el estado, necesitamos reaccionar a ese estado
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;
  //Así, cuando nuestro authStatus notifique, automáticamente va a notificar al router.
  set authStatus (AuthStatus value){
    _authStatus = value;
    notifyListeners();
  }
}