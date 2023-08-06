import 'package:betweener_project/views/login_view.dart';
import 'package:betweener_project/views/main_app_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingView extends StatefulWidget {
  static const id = '/loadingView';
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  void checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user') && mounted) {
      print('navigate to main');
      Navigator.pushNamed(context, MainAppView.id);
    } else {
      Navigator.pushNamed(context, LoginView.id);
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
