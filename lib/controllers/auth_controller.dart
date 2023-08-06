import 'package:betweener_project/constants.dart';
import 'package:betweener_project/models/user.dart';
import 'package:http/http.dart' as http;

Future<User> login(Map<String, String> body) async {
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
