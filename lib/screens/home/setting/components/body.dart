import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/providers/auth.dart';

import 'package:st_school_app/widgets/profile_image.dart';

import 'setting_menu.dart';
import 'setting_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfileImage(
            imagePath:
                "https://scontent.fpnh22-4.fna.fbcdn.net/v/t1.18169-9/14993308_1930517297175926_3226462828616400930_n.jpg?_nc_cat=108&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=NA-ztCO7hSIAX9khhQy&_nc_ht=scontent.fpnh22-4.fna&oh=00_AT9MO0aRRvA5UzbUAIThwBC3YKG0iHgX-FpGY05Z3EXv8w&oe=6288AAE3",
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 20),
          SettingMenu(
            text: "Notifications",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          const SizedBox(height: 10),
          SettingMenu(
            text: "Change Password",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          const SizedBox(height: 10),
          SettingMenu(
            text: "Helps",
            icon: "assets/icons/Conversation.svg",
            press: () {},
          ),
          const SizedBox(height: 10),
          SettingMenu(
            text: "Log out",
            icon: "assets/icons/Log out.svg",
            press: () {
              // final auth = Provider.of<Auth>(context, listen: false);
              // auth.logout();

              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () {
          //     // Navigator.of(context).pushReplacementNamed();
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.question_answer),
          //   title: Text('Question'),
          //   onTap: () {
          //     // Navigator.of(context).pushReplacementNamed();
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.exit_to_app),
          //   title: Text('Logout'),
          //   onTap: () {
          //     final auth = Provider.of<Auth>(context, listen: false);
          //     auth.logout();

          //     Navigator.of(context).pop();
          //     Navigator.of(context).pushReplacementNamed('/');
          //   },
          // ),
        ],
      ),
    );
  }
}
