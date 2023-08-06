import 'dart:convert';

import 'package:betweener_project/constants.dart';
import 'package:betweener_project/models/follow.dart';
import 'package:betweener_project/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> follow(int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);
  final response = await http.post(Uri.parse(followUrl),
      body: {'followee_id': id.toString()},
      headers: {'Authorization': 'Bearer ${user.token}'});
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['message'];
  } else if (response.statusCode == 500) {
    throw Exception('Follow Failed !');
  } else {
    throw Exception('Follow Failed !');
  }
}

Future<Follow> follow_follwee_info() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  User user = userFromJson(prefs.getString('user')!);
  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data);
    return  Follow.fromJson(data);
  } else if (response.statusCode == 500) {
    throw Exception('Follow Failed !');
  } else {
    throw Exception('Follow Failed !');
  }
}
