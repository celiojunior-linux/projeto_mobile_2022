import 'package:task_app/models/user.dart';
import 'package:task_app/services/authenticator.dart';

class AuthDucks{

  static final AuthDucks _authDucks = AuthDucks._internal();
  User? currentUser;

  factory AuthDucks(){
    return _authDucks;
  }

  AuthDucks._internal();

  Future<Map<String, String>?> getAuthenticationHeaders() async{
    String? token = await Authenticator().getToken(currentUser!.username, currentUser!.password);
    return {'Authorization': 'Bearer $token'};
  }

}