import 'package:betweener_project/provider/link_provider.dart';
import 'package:betweener_project/storage/shared_preference_controller.dart';
import 'package:betweener_project/views/screens/auth/login_view.dart';
import 'package:betweener_project/views/screens/auth/register_view.dart';
import 'package:betweener_project/views/screens/edit_user_info.dart';
import 'package:betweener_project/views/screens/home/home_view.dart';
import 'package:betweener_project/views/screens/loading/loading_view.dart';
import 'package:betweener_project/views/screens/location_screen.dart';
import 'package:betweener_project/views/screens/main_app_view.dart';
import 'package:betweener_project/views/screens/profile/profile_view.dart';
import 'package:betweener_project/views/screens/receive/receive_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceController().initPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return LinkProvider();
      },
      child: MaterialApp(
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
          LocationScreen.id: (context) => const LocationScreen(),
          ReceiveView.id: (context) => const ReceiveView(),
          EditUserInfo.id: (context) => const EditUserInfo(),
        },
      ),
    );
  }
}
