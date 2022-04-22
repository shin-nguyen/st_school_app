import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:st_school_app/widgets/button.dart';
import 'package:st_school_app/widgets/text_field.dart';
import 'package:st_school_app/widgets/profile_image.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    // final user = UserPreferences.myUser;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileImage(
            imagePath:
                "https://scontent.fpnh22-4.fna.fbcdn.net/v/t1.18169-9/14993308_1930517297175926_3226462828616400930_n.jpg?_nc_cat=108&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=NA-ztCO7hSIAX9khhQy&_nc_ht=scontent.fpnh22-4.fna&oh=00_AT9MO0aRRvA5UzbUAIThwBC3YKG0iHgX-FpGY05Z3EXv8w&oe=6288AAE3",
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: "Kai Akatsuki",
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'First Name',
            text: "Kai",
            onChanged: (email) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Last Name',
            text: "Akatsuki",
            onChanged: (email) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: "sinhnguyen@gmail.com",
            onChanged: (email) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Phone',
            text: "01020312312",
            onChanged: (email) {},
          ),
          const SizedBox(height: 24),
          SizedBox(
              height: 30,
              width: 50,
              child: ButtonWidget(text: "Save", onClicked: () => {})),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
