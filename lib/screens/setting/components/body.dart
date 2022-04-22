import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth.dart';
import 'setting_menu.dart';
import 'setting_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SettingPic(),
          SizedBox(height: 20),
          // SettingMenu(
          //   text: "My Account",
          //   icon: "assets/icons/User Icon.svg",
          //   press: () => {},
          // ),
          // SettingMenu(
          //   text: "Notifications",
          //   icon: "assets/icons/Bell.svg",
          //   press: () {},
          // ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Navigator.of(context).pushReplacementNamed();
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text('Question'),
            onTap: () {
              // Navigator.of(context).pushReplacementNamed();
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              final auth = Provider.of<Auth>(context, listen: false);
              auth.logout();

              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
