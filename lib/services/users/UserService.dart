import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mangaonline/main.dart';
import 'package:mangaonline/models/user/User.dart';
import 'package:mangaonline/utils/statics.dart';

Future login(String email, String password) async {
  final response = await http.post(
      'https://xn--80aai8ag.xn--80asehdb/api/v2/auth/login',
      body: {'email': email, 'password': password});

  dynamic res = jsonDecode(response.body);

  if(!res.containsKey('errors')){
    await storage.write(key: 'token', value: res['token']);
    print(res["token"]);
  }

  return res;
}

void logout() async {
  String token = await storage.read(key: 'token');
  if (token != null){
    await http.post('https://xn--80aai8ag.xn--80asehdb/api/v2/auth/logout', headers: {
      HttpHeaders.authorizationHeader : 'Bearer ' + token
    });
    await storage.delete(key: 'token');
  }
}

Future<User> getUser() async {
  String token = await storage.read(key: 'token');

  Object headers;
  if(token != null) headers = {HttpHeaders.authorizationHeader : 'Bearer ' + token};

  final response = await http
      .get(apiUri + '/user/me', headers: headers);


  dynamic user = jsonDecode(response.body);

  if (user.length > 0 && user != null) {
    return User.fromJson(user);
  } else {
    return null;
  }
}

Future<bool> isLogin() async {
  String token = await storage.read(key: 'token');
  return (token != null)?true:false;
}
