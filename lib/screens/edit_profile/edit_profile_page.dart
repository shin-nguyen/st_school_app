import 'package:flutter/material.dart';
import 'package:st_school_app/constants/colors.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/widgets/large_buttons.dart';
import 'package:st_school_app/widgets/text_field.dart';
import 'package:st_school_app/widgets/profile_image.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  static const routeName = '/edit-profile';

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserNotifier>(contex t);

    return Scaffold(
        backgroundColor: background,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(appPadding),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: spacer),
              const SizedBox(
                height: 10,
              ),
              ProfileImage(
                imagePath:
                    "https://haycafe.vn/wp-content/uploads/2021/11/Anh-avatar-dep-chat-lam-hinh-dai-dien.jpg",
                isEdit: true,
                onClicked: () async {},
              ),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: 'Full Name',
                text: "Kai Akatsukiii",
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
              AppLargeButton(
                text: "Done",
                backgroundColor: Colors.white,
                textColor: secondary,
                onTap: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   CartPage.routeName,
                  // );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ));
  }
}
