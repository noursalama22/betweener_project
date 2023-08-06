import 'package:betweener_project/views/home_view.dart';
import 'package:betweener_project/views/loading_view.dart';
import 'package:betweener_project/views/login_view.dart';
import 'package:betweener_project/views/main_app_view.dart';
import 'package:betweener_project/views/profile_view.dart';
import 'package:betweener_project/views/receive_view.dart';
import 'package:betweener_project/views/register_view.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Betweener',
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: kPrimaryColor,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
          scaffoldBackgroundColor: kScaffoldColor),
      home: const LoadingView(),
      routes: {
        LoadingView.id: (context) => const LoadingView(),
        LoginView.id: (context) => const LoginView(),
        RegisterView.id: (context) => const RegisterView(),
        HomeView.id: (context) => const HomeView(),
        MainAppView.id: (context) => const MainAppView(),
        ProfileView.id: (context) => const ProfileView(),
        ReceiveView.id: (context) => const ReceiveView(),
      },
    );
  }
}
