import 'dart:convert';

import 'package:betweener_project/api/api_helper.dart';
import 'package:betweener_project/core/utils/constants.dart';
import 'package:betweener_project/models/auth_api_response.dart';
import 'package:betweener_project/storage/shared_preference_controller.dart';
import 'package:betweener_project/views/screens/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/link.dart';

class LinkController with ApiHelper {
  Future<List<Link>> getLinks(context) async {
    //print(headers);
    var response = await http.get(Uri.parse(linksUrl), headers: headers);

    // print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['links'] as List<dynamic>;

      return data.map((e) => Link.fromJson(e)).toList();
    }

    if (response.statusCode == 401) {
      Navigator.pushReplacementNamed(context, LoginView.id);
    }

    return Future.error('Somthing wrong');
  }

  Future<bool> addNewLink(Map<String, String> body) async {
    final response =
        await http.post(Uri.parse(linksUrl), headers: headers, body: body);

    if (response.statusCode == 200) {
      //  final data = jsonDecode(response.body)['link'];
      //  print(data);
      return true;
    } else {
      return false;
    }
  }

  Future<AuthApiResponse> deleteLinks(int linkId) async {
    final response = await http
        .delete(Uri.parse('$linksUrl/${linkId.toString()}'), headers: headers);
    if (response.statusCode == 200) {
      return AuthApiResponse(
          message: jsonDecode(response.body)['message'], status: true);
    } else if (response.statusCode == 404) {
      return AuthApiResponse(message: 'Delete Failed', status: false);
    } else {
      return errorServerResponse;
    }
  }

//200 "message": "updated successfully"
  // 401     "message": "unauthenticated"
  // 404
  Future<String> updateLinks(int linkId,
      {required title, required link}) async {
    final response = await http.put(Uri.parse('$linksUrl/${linkId.toString()}'),
        headers: headers,
        body: {
          'title': title,
          'username': SharedPreferenceController().getCurrentUser().user!.name
        });
    print('***********************${response.statusCode}');
    if (response.statusCode == 200) {
      print(jsonDecode(response.body)['message']);
      return jsonDecode(response.body)['message'];
    } else {
      throw Exception('Update Failed');
    }
  }
}
