import 'package:flutter/material.dart';
import 'package:task_app/functions/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:task_app/models/user.dart';
import 'dart:convert';

import 'package:task_app/store/ducks/auth.dart';

class Authenticator {
  final Uri tokenUrl = Uri.http(Api.baseUrl, Api.tokenEndpoint);
  final Uri tokenRefreshUrl = Uri.http(Api.baseUrl, Api.tokenRefreshEndpoint);

  Future<String?> getToken(String username, String password) async {
    http.Response response = await http.post(
      tokenUrl,
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 401 || response.statusCode == 400) {
      return Future.error(http.ClientException('Uma ou mais credenciais inválidas.'));
    } else if (response.statusCode == 200) {
      AuthDucks().currentUser = User(id: null, username: username, password: password);
      Map<String, dynamic> data = json.decode(response.body);
      return data['access'];
    }
    AuthDucks().currentUser = null;
    return null;
  }

}
