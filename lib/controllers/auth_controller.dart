import 'dart:convert';

import 'package:betweener_project/constants.dart';
import 'package:betweener_project/models/user.dart';
import 'package:http/http.dart' as http;

Future<User> login(body) async {
  final response = await http.post(
    Uri.parse(loginUrl),
    body: body,
  );

  if (response.statusCode == 200) {
    return userFromJson(response.body);
  } else {
    throw Exception('Failed to login');
  }
}

Future<String> register(body) async {
  final response = await http.post(
    Uri.parse(registerUrl),
    body: body,
  );
  print('*********************${response}');
  if (response.statusCode == 201) {
    return jsonDecode(response.body)['message'];
  } else if(response.statusCode == 200) {
    throw Exception(jsonDecode(response.body)['message'] +
        jsonDecode(response.body)['errors']);
  }else{
    throw Exception('Failed to register');
  }
}
