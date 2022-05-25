import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/account_menu_json.dart';
import 'package:st_school_app/providers/auth_notifier.dart';
import 'package:st_school_app/widgets/custom_button_box.dart';
import 'package:st_school_app/widgets/custom_place_holder.dart';
import 'package:st_school_app/widgets/custom_title.dart';

import 'package:st_school_app/widgets/profile_image.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        children: [
          const SizedBox(height: spacer - 1.0),
          ProfileImage(
            imagePath:
                "https://haycafe.vn/wp-content/uploads/2021/11/Anh-avatar-dep-chat-lam-hinh-dai-dien.jpg",
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: spacer),
          Column(
            children: List.generate(accountMenuJson.length, (indexTitle) {
              List data = accountMenuJson[indexTitle]['categories'];
              return Padding(
                padding: const EdgeInsets.only(bottom: spacer),
                child: Column(
                  children: [
                    CustomTitle(
                      title: accountMenuJson[indexTitle]['title'],
                      extend: false,
                    ),
                    const SizedBox(height: smallSpacer),
                    Column(
                      children: List.generate(data.length, (indexSubTitle) {
                        return CunstomPlaceHolder(
                          title: data[indexSubTitle]['title'],
                          isSwitch: data[indexSubTitle]['isSwitch'],
                        );
                      }),
                    )
                  ],
                ),
              );
            }),
          ),

          const SizedBox(height: spacer),
          GestureDetector(
            onTap: () {
              final auth = Provider.of<AuthNotifier>(context, listen: false);
              auth.logout();

              Navigator.of(context).pushReplacementNamed('/');
            },
            child: const CustomButtonBox(title: 'Log out'),
          ),
          // SettingMenu(
          //   text: "Notifications",
          //   icon: "assets/icons/User Icon.svg",
          //   press: () => {},
          // ),
          // const SizedBox(height: 10),
          // SettingMenu(
          //   text: "Change Password",
          //   icon: "assets/icons/Settings.svg",
          //   press: () {},
          // ),
          // const SizedBox(height: 10),
          // SettingMenu(
          //   text: "Helps",
          //   icon: "assets/icons/Conversation.svg",
          //   press: () {},
          // ),
          // const SizedBox(height: 10),
          // SettingMenu(
          //   text: "Log out",
          //   icon: "assets/icons/Log out.svg",
          //   press: () {
          //     // final auth = Provider.of<Auth>(context, listen: false);
          //     // auth.logout();

          //     Navigator.of(context).pop();
          //     Navigator.of(context).pushReplacementNamed('/');
          //   },
          // ),
        ],
      ),
    );
  }
}
