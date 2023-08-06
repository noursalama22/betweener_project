import 'package:betweener_project/constants.dart';
import 'package:betweener_project/controllers/follow_controller.dart';
import 'package:betweener_project/controllers/user_controller.dart';
import 'package:betweener_project/models/follow.dart';
import 'package:betweener_project/models/user.dart';
import 'package:betweener_project/views/widgets/custom_text_form_field.dart';
import 'package:betweener_project/views/widgets/secondary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../controllers/link_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController userController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<UserClass> users = [];
  Follow followinfo = Follow();
  bool isListVisible = false;
  List<int> following_ids = [];
  void searchUser() {
    if (_formKey.currentState!.validate()) {
      final username = userController.text;

      getSearchUser(username).then((user) async {
        print('**********************${user.length}');

        //save user locally
        // final SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString('user', userToJson(user));
        isListVisible = true;
        print(isListVisible);
        users = user;
        setState(() {
          users = user;
        });
        follow_follwee_info().then((value) {
          followinfo = value;
          print('${value}*******************************');
          if (followinfo != null && followinfo.following != null) {
            following_ids = followinfo.following!.map((e) => e.id!).toList();
          }
          setState(() {
            
          });
          print('******************${following_ids.length}');
        });

        setState(() {});
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
          backgroundColor: Colors.red,
        ));
      });

      // Navigator.pushNamed(context, MainAppView.id);
    }
  }

  void addFollower(int id) {
    
    follow(id).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(value),
        backgroundColor: Colors.green,
      ));
       follow_follwee_info().then((value) {
        followinfo = value;
        print('${value}*******************************');
        if (followinfo != null && followinfo.following != null) {
          following_ids = followinfo.following!.map((e) => e.id!).toList();
        }
        setState(() {});
        print('******************${following_ids.length}');
      });
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.toString()),
        backgroundColor: Colors.red,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: kPrimaryTextStyle.copyWith(fontSize: 20),
        ),
        backgroundColor: kLightPrimaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: kPrimaryColor,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Visibility(
            visible: isListVisible,
            child: IconButton(
              icon: Icon(
                Icons.search,
                size: 24,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  userController.clear();
                  isListVisible = !isListVisible;
                });
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: !isListVisible,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        label: 'User Name',
                        controller: userController,
                        hint: 'Enter user name',
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter the title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SecondaryButtonWidget(
                          onTap: () {
                            searchUser();
                          },
                          text: 'Search'),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Visibility(
                  visible: isListVisible,
                  child: users.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning,
                              color: Colors.black38,
                            ),
                            Text(
                              'No User Found!',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black38),
                            ),
                          ],
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            print('Hello');
                            return Material(
                              borderRadius: BorderRadius.circular(12),

                              color:
                                  kPrimaryColor, // shape: Border.all(color: kPrimaryColor, width: 2),
                              // color: kPrimaryColor,
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                leading: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  maxRadius: 32,
                                  child: Icon(Icons.person),
                                ),
                                subtitle: Text(
                                  '${users[index].email}',
                                  style: kSecondryTextStyle.copyWith(
                                      color: Colors.grey),
                                ),
                                title: Text(
                                  '${users[index].name}',
                                  style: kSecondryTextStyle.copyWith(
                                      color: Colors.white),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    following_ids.contains(users[index].id)
                                        ? Icons.check_box
                                        : Icons.person_add,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  onPressed:
                                      following_ids.contains(users[index].id)
                                          ? null
                                          : () {
                                              addFollower(users[index].id!);
                                              setState(() {
                                                
                                              });
                                            },
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: users.length),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// add link  Done>>>>>
// search  Done>>>>> 
//add followers  Done >>>>
//get follow info  Done >>>> 
//profile page  HALF DONE ???
