import 'dart:convert';

import 'package:betweener_project/constants.dart';
import 'package:betweener_project/models/user.dart';
import 'package:betweener_project/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/link.dart';

Future<List<Link>> getLinks(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.get(Uri.parse(linksUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  print(jsonDecode(response.body)['links']);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['links'] as List<dynamic>;

    return data.map((e) => Link.fromJson(e)).toList();
  }

  if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Somthing wrong');
}

Future<Link> addNewLink(Map<String, String> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);
  final response = await http.post(Uri.parse(linksUrl),
      headers: {'Authorization': 'Bearer ${user.token}'}, body: body);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['link'];
    print(data);
    return Link.fromJson(data);
  } else {
    throw Exception('Linked not added');
  }
}

Future<String> deleteLinks(int linkId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);
  final response = await http.delete(
      Uri.parse('$linksUrl/${linkId.toString()}'),
      headers: {'Authorization': 'Bearer ${user.token}'});
  print('***********************${response.statusCode}');
  if (response.statusCode == 200) {
    return jsonDecode(response.body)['message'];
  } else {
    throw Exception('Delete Failed');
  }
}
