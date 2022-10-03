import 'package:task_app/functions/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:task_app/store/ducks/auth.dart';

class UserService {
  final Uri signupUrl = Uri.http(Api.baseUrl, Api.userSignupEndpoint);
  final Uri infoUrl = Uri.http(Api.baseUrl, Api.userInfoEndpoint);

  Future<bool?> createUser(Map<String, dynamic> userData) async {
    http.Response response = await http.post(
      signupUrl,
      body: {
        'username': userData['username'],
        'password': userData['password'],
      },
    );
    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 400){
      return Future.error('Usuário já existe');
    }
    return false;
  }

  Future<Map<String, dynamic>?> getCurrentUserInfo() async {
    Map<String, String>? headers = await AuthDucks().getAuthenticationHeaders();
    http.Response response = await http.get(infoUrl, headers: headers);
    return json.decode(response.body);
  }
}
