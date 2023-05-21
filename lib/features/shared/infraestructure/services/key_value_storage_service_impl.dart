import 'package:shared_preferences/shared_preferences.dart';
import 'key_value_storage_service.dart';



//Aquí utilizamos SharedPreferences. ¿Queremos mudarnos luego a futuro 
//¿a flutter_secure_storage porque quien leches almacena de forma insegura un token?
//Sólo tenemos que cambiar la clase y extienda de KeyValueStorageService ^^. PORQUE LO QUE USAMOS en el "cliente"
//en las clases que lo utilizamos, no es la implementación en si misma, sino el target.

//Mola mucho sí ^^. Mi gusta
class KeyValueStorageServiceImpl extends KeyValueStorageService {

  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }


  @override
  Future<T?> getValue<T>(String key) async{
    final prefs = await getSharedPrefs();

    switch(T) {
      case int:
        return prefs.getInt( key ) as T?;
        

      case String:
        return prefs.getString(key) as T?;

      default:
        throw UnimplementedError('GET not implemented for type ${ T.runtimeType }');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();

    switch(T) {
      case int:
        prefs.setInt( key, value as int );
        break;

      case String:
        prefs.setString(key, value as String);
        break;

      default:
        throw UnimplementedError('Set not implemented for type ${ T.runtimeType }');
    }
    
  }

}