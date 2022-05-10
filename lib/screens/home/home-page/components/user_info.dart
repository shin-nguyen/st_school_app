import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/providers/user_notifier.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProfile = Provider.of<UserNotifier>(context).getUser;

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Hi ${userProfile.firstName}",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Today is a good day\nto learn something new!",
                style: TextStyle(
                  color: Colors.black54,
                  wordSpacing: 2.5,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: kpurple,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withOpacity(0.7),
                        spreadRadius: 0.0,
                        blurRadius: 6.0,
                        offset: const Offset(0, 2),
                      )
                    ],
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(userProfile.avatar))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
