import 'package:betweener_project/constants.dart';
import 'package:betweener_project/controllers/follow_controller.dart';
import 'package:betweener_project/controllers/link_controller.dart';
import 'package:betweener_project/controllers/user_controller.dart';
import 'package:betweener_project/models/follow.dart';
import 'package:betweener_project/models/link.dart';
import 'package:betweener_project/models/user.dart';
import 'package:betweener_project/views/add_link_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProfileView extends StatefulWidget {
  static String id = '/profileView';

  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<List<Link>> links;
  late Future<User> user;
  Follow? followinfo;
  getFollowingInfo() {
    follow_follwee_info().then((value) {
      setState(() {
        followinfo = value;
      });
    });
  }

  deleteLink(int linkId) {
    deleteLinks(linkId).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(value),
        backgroundColor: Colors.green,
      ));
    }).catchError((onError)
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(onError.toString()),
        backgroundColor: Colors.red,
      ));
    });
     setState(() {
      links = getLinks(context);
    });
  }

  void initState() {
    user = getLocalUser();
    links = getLinks(context);
    getFollowingInfo();

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Profile',
          style: kPrimaryTextStyle.copyWith(
            fontSize: 24,
          ),
        ),
      ),
      body: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kPrimaryColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            maxRadius: 64,
                            backgroundImage:
                                AssetImage('assets/imgs/person.png'),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: FutureBuilder(
                                future: user,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${snapshot.data!.user!.name}',
                                          style: kPrimaryTextStyle.copyWith(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          '${snapshot.data!.user!.email}',
                                          style: kPrimaryTextStyle.copyWith(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          '+97000000000',
                                          style: kPrimaryTextStyle.copyWith(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: kSecondaryColor,
                                              ),
                                              child: Text(
                                                followinfo == null
                                                    ? 'Loading'
                                                    : 'followers ${followinfo!.followers_count}',
                                                style:
                                                    kPrimaryTextStyle.copyWith(
                                                  fontSize: 8,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: kSecondaryColor,
                                              ),
                                              child: Text(
                                                followinfo == null
                                                    ? 'Loading'
                                                    : 'followering ${followinfo!.following_count}',
                                                style:
                                                    kPrimaryTextStyle.copyWith(
                                                  fontSize: 8,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return Text(snapshot.error.toString());
                                  }
                                  return const Text('loading');
                                },
                              ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: links,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                vertical: 30,
                              ),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final title = snapshot.data?[index].title;
                                final link = snapshot.data?[index].link;
                                final id = snapshot.data?[index].id;
                                return Slidable(
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SizedBox(
                                        width: 12,
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          
                                        },
                                        backgroundColor: kSecondaryColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                        // label: 'Save',
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          deleteLink(id!);
                                          
                                         
                                        },
                                        backgroundColor: Color(0xFFF56C61),
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        // label: 'Save',
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      // Container(
                                      //   margin: const EdgeInsetsDirectional
                                      //       .symmetric(
                                      //     horizontal: 12,
                                      //   ),
                                      //   padding: const EdgeInsetsDirectional
                                      //       .symmetric(
                                      //     horizontal: 16,
                                      //     vertical: 16,
                                      //   ),
                                      //   alignment: AlignmentDirectional.center,
                                      //   decoration: BoxDecoration(
                                      //       color: kSecondaryColor,
                                      //       borderRadius:
                                      //           BorderRadius.circular(12)),
                                      //   child: const Icon(
                                      //     Icons.edit,
                                      //     size: 28,
                                      //     color: Colors.white,
                                      //   ),
                                      // ),
                                      // Container(
                                      //   margin: const EdgeInsetsDirectional
                                      //       .symmetric(
                                      //     horizontal: 12,
                                      //   ),
                                      //   padding: const EdgeInsetsDirectional
                                      //       .symmetric(
                                      //     horizontal: 16,
                                      //     vertical: 16,
                                      //   ),
                                      //   alignment: AlignmentDirectional.center,
                                      //   decoration: BoxDecoration(
                                      //     color: Color(0xFFF56C61),
                                      //     borderRadius:
                                      //         BorderRadius.circular(12),
                                      //   ),
                                      //   child: const Icon(Icons.delete,
                                      //       size: 28, color: Colors.white),
                                      // ),
                                    ],
                                  ),
                                  child: Container(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                          color: index % 2 == 0
                                              ? kLightDangerColor
                                              : kLightPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${title!.toUpperCase()}',
                                            style: kPrimaryTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: index % 2 == 0
                                                  ? kOnLightDangerColor
                                                  : kPrimaryColor,
                                              letterSpacing: 2,
                                            ),
                                          ),
                                          Text(
                                            '$link',
                                            style: kPrimaryTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: index % 2 == 0
                                                  ? Color(0xFF9B6A73)
                                                  : Color(0xFF807D99),
                                            ),
                                          ),
                                        ],
                                      )),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 24,
                                );
                              },
                              itemCount: snapshot.data!.length);
                        }
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return const Text('loading');
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                child: IconButton(
                  icon: const Icon(Icons.edit, size: 32, color: Colors.white),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 100, right: 20),
          child: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const AddLinkScreen();
              })).then((value) {
                links = getLinks(context);
                setState(() {});
              });
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ]),
    );
  }
}
