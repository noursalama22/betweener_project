import 'package:betweener_project/constants.dart';
import 'package:betweener_project/views/add_link_screen.dart';
import 'package:betweener_project/views/home_view.dart';
import 'package:betweener_project/views/profile_view.dart';
import 'package:betweener_project/views/receive_view.dart';
import 'package:betweener_project/views/widgets/custom_floating_nav_bar.dart';
import 'package:flutter/material.dart';

class MainAppView extends StatefulWidget {
  static String id = '/mainAppView';

  const MainAppView({super.key});

  @override
  State<MainAppView> createState() => _MainAppViewState();
}

class _MainAppViewState extends State<MainAppView> {
  int _currentIndex = 1;

  late List<Widget?> screensList = [
    const ReceiveView(),
    const HomeView(),
    const ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      // // floatingActionButton: Visibility(
      //   visible: _currentIndex == 2,
      //   // child: FloatingActionButton(
      //   //   backgroundColor: kPrimaryColor,
      //   //   shape: CircleBorder(),
      //   //   onPressed: () {
      //   //     Navigator.push(context,
      //   //         MaterialPageRoute(builder: (BuildContext context) {
      //   //       return AddLinkScreen();
      //   //     })).then((value) {

      //   //     });
      //   //   },
      //   //   child: Icon(
      //   //     Icons.add,
      //   //     color: Colors.white,
      //   //   ),
      //   ),
      // ),
      body: screensList[_currentIndex],
      extendBody: true,
      bottomNavigationBar: CustomFloatingNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
