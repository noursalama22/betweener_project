import 'package:betweener_project/constants.dart';
import 'package:betweener_project/controllers/auth_controller.dart';
import 'package:betweener_project/controllers/link_controller.dart';
import 'package:betweener_project/models/user.dart';
import 'package:betweener_project/views/main_app_view.dart';
import 'package:betweener_project/views/widgets/custom_text_form_field.dart';
import 'package:betweener_project/views/widgets/secondary_button_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddLinkScreen extends StatefulWidget {
  const AddLinkScreen({super.key});

  @override
  State<AddLinkScreen> createState() => _AddLinkScreenState();
}

class _AddLinkScreenState extends State<AddLinkScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> submitLink() async {
    if (_formKey.currentState!.validate()) {
      String username = '';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('user')) {
        username = userFromJson(prefs.getString('user')!).user!.name!;
      }
      final body = {
        'title': titleController.text,
        'link': linkController.text,
        'username': username,
      };

      addNewLink(body).then((user) async {
        //save user locally
        // final SharedPreferences prefs = await SharedPreferences.getInstance();
        // await prefs.setString('user', userToJson(user));

        if (mounted) {
          Navigator.pop(context);
        }
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
          backgroundColor: Colors.red,
        ));
      });

      // Navigator.pushNamed(context, MainAppView.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Link',
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
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  CustomTextFormField(
                    controller: titleController,
                    hint: 'snapshat',
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    label: 'Title',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomTextFormField(
                    controller: linkController,
                    hint: 'http:google.com',
                    label: 'Link',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter the password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SecondaryButtonWidget(
                    onTap: () {
                      submitLink();
                    },
                    text: 'ADD',
                    width: 140,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
