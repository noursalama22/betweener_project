import 'dart:convert';

import 'package:betweener_project/api/api_helper.dart';
import 'package:betweener_project/core/utils/constants.dart';
import 'package:betweener_project/models/auth_api_response.dart';
import 'package:betweener_project/models/user.dart';
import 'package:betweener_project/storage/shared_preference_controller.dart';
import 'package:http/http.dart' as http;

class AuthApiController with ApiHelper {
  Future<AuthApiResponse> login(
      {required String email, required String password}) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200 || response.statusCode == 400) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        User user = userFromJson(response.body);
        SharedPreferenceController().save(user);
      }
      return response.statusCode == 200
          ? AuthApiResponse(message: 'Logged In Succseefuly', status: true)
          : AuthApiResponse(message: jsonResponse['message'], status: false);
    } else {
      return errorServerResponse;
    }
  }

  Future<AuthApiResponse> register(
      {required String name,
      required String email,
      required String password}) async {
    final response = await http.post(
      Uri.parse(registerUrl),
      body: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        User user = userFromJson(response.body);
        SharedPreferenceController().save(user);
        return AuthApiResponse(
            message: 'Registered Succssefully', status: true);
      } else {
       return AuthApiResponse(
            message: getRegisterErrors(jsonResponse['errors']), status: false);
      }
    } else {
      return errorServerResponse;
    }
  }

  String getRegisterErrors(error) {
    if (error['email'] != null)
      return error['email'][0];
    else
      return 'something wrong';
  }
}
