import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/latest_workout.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
import 'package:st_school_app/providers/user_notifier.dart';
import 'package:st_school_app/screens/edit_profile/edit_profile_page.dart';
import 'package:st_school_app/widgets/profile_image.dart';
import 'package:st_school_app/widgets/profile_number.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserNotifier>(context);
    final courses = Provider.of<CoursesNotifier>(context);

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 30),
          ProfileImage(
            imagePath: user.getUser.avatar,
            onClicked: () {
              Navigator.pushNamed(
                context,
                EditProfilePage.routeName,
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(user.getUser.firstName + user.getUser.lastName,
              user.getUser.email),
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
            child: Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x0000ffd8),
                          offset: Offset(1, 1),
                          blurRadius: 20.0,
                          spreadRadius: 10)
                    ]),
                height: h * 0.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NumbersWidget(
                      all: courses.getCourses.length,
                      inProress: courses.findByInProgress(),
                      done: courses.findByDone(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: spacer),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Activity Progress",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textBlack),
                ),
                Container(
                  width: 95,
                  height: 35,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [secondary, primary]),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Weekly",
                        style: TextStyle(fontSize: 13, color: textWhite),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: textWhite,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: w - 30,
            height: 200,
            decoration: BoxDecoration(
                color: textWhite,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 20,
                    blurRadius: 10,
                    color: textBlack.withOpacity(0.01),
                    offset: const Offset(0, 1),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(weekly.length, (index) {
                  return Column(
                    children: [
                      Flexible(
                        child: Stack(
                          children: [
                            Container(
                              width: 20,
                              height: h,
                              decoration: BoxDecoration(
                                color: bgTextField,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: 20,
                                height: h * (weekly[index]['count']),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: weekly[index]['color']),
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        weekly[index]['day'],
                        style: const TextStyle(fontSize: 13),
                      )
                    ],
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildAbout(user.getUser.about),
          SizedBox(height: h * 0.02),
        ],
      ),
    );
  }

  Widget buildName(name, email) => Column(
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      );

  Widget buildAbout(about) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              about != '' ? about : "Some thing about me",
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
