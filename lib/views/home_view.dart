import 'package:betweener_project/controllers/link_controller.dart';
import 'package:betweener_project/controllers/user_controller.dart';
import 'package:betweener_project/views/add_link_screen.dart';
import 'package:betweener_project/views/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:font_awesome_flutter_example/icons.dart';
import '../constants.dart';
import '../models/link.dart';
import '../models/user.dart';

class HomeView extends StatefulWidget {
  static String id = '/homeView';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<User> user;
  late Future<List<Link>> links;

  @override
  void initState() {
    user = getLocalUser();
    links = getLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 24,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return SearchScreen();
                },
              ));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.qr_code_scanner,
              size: 24,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 16,
          end: 16,
          bottom: 100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: EdgeInsets.only(right: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       IconButton(
            //         icon: Icon(
            //           Icons.search,
            //           size: 32,
            //         ),
            //         onPressed: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) {
            //                 return SearchScreen();
            //               },
            //             ),
            //           );
            //         },
            //       ),
            //     ],
            //   ),
            // ),

            FutureBuilder(
              future: user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'Hello, ${snapshot.data?.user?.name}!',
                    style: kPrimaryTextStyle,
                  );
                }
                return Text('loading');
              },
            ),
            Container(
              alignment: AlignmentDirectional.center,
              child: Image.asset(
                'assets/imgs/qr_code.png',
                // width: 240,
                // height: 240,
                color: kPrimaryColor,
              ),
            ),

            Divider(
              indent: 80,
              endIndent: 80,
              thickness: 2,
              color: Colors.black,
            ),
            FutureBuilder(
              future: links,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    height: 116,
                    child: ListView.separated(
                        padding: EdgeInsets.all(12),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // print(snapshot.data!.links[]);

                          return index == snapshot.data!.length
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return AddLinkScreen();
                                    })).then((value) {
                                      links = getLinks(context);
                                      setState(() {});
                                    });
                                    //TODO:
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 26, vertical: 16),
                                    decoration: BoxDecoration(
                                        color: kLightPrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: kPrimaryColor,
                                          size: 32,
                                        ),
                                        Text(
                                          'Add More',
                                          style: kSecondryTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: kPrimaryColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 26, vertical: 16),
                                  decoration: BoxDecoration(
                                      color: kLightSecondaryColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${snapshot.data![index].title}',
                                        style: kSecondryTextStyle,
                                      ),
                                      Text(
                                        '${snapshot.data![index].username}',
                                        style: kSecondryTextStyle.copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 20,
                          );
                        },
                        itemCount: (snapshot.data!.length + 1)),
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Text('loading');
              },
            ),
          ],
        ),
      ),
    );
  }
}
