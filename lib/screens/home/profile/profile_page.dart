import 'package:flutter/material.dart';
import 'package:st_school_app/screens/edit_profile/edit_profile_page.dart';
import 'package:st_school_app/widgets/profile_image.dart';
import 'package:st_school_app/widgets/button.dart';
import 'package:st_school_app/widgets/profile_number.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // final user = UserPreferences.myUser;

    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 30),
          ProfileImage(
            imagePath:
                "https://scontent.fpnh22-4.fna.fbcdn.net/v/t1.18169-9/14993308_1930517297175926_3226462828616400930_n.jpg?_nc_cat=108&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=NA-ztCO7hSIAX9khhQy&_nc_ht=scontent.fpnh22-4.fna&oh=00_AT9MO0aRRvA5UzbUAIThwBC3YKG0iHgX-FpGY05Z3EXv8w&oe=6288AAE3",
            onClicked: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfilePage()),
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(),
        ],
      ),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            "Kai Akatsuki",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            "sinhnguyen2702@gmail.com",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            "0365050432",
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade to PRO',
        onClicked: () {},
      );

  Widget buildAbout() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "Some thing about me",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
