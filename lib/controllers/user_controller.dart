import 'dart:convert';
import 'package:betweener_project/storage/shared_preference_controller.dart';
import 'package:flutter/material.dart';

import 'package:betweener_project/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

import 'package:http/http.dart' as http;



Future<List<UserClass>> getSearchUser(username) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.post(Uri.parse(searchUrl),
      headers: {'Authorization': 'Bearer ${user.token}'},
      body: {'name': username});

  print(jsonDecode(response.body)['user']);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['user'] as List<dynamic>;

    return data.map((e) => UserClass.fromJson(e)).toList();
  }

  if (response.statusCode == 401) {
    // Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Somthing wrong');
}
