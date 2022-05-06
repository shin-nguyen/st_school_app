import 'package:flutter/material.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/account_menu_json.dart';
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
                "https://scontent.fpnh22-4.fna.fbcdn.net/v/t1.18169-9/14993308_1930517297175926_3226462828616400930_n.jpg?_nc_cat=108&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=NA-ztCO7hSIAX9khhQy&_nc_ht=scontent.fpnh22-4.fna&oh=00_AT9MO0aRRvA5UzbUAIThwBC3YKG0iHgX-FpGY05Z3EXv8w&oe=6288AAE3",
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
            onTap: () async {},
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
