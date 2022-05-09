import 'package:flutter/material.dart';

import 'components/body.dart';

class SettingPage extends StatelessWidget {
  static String routeName = "/setting";

  const SettingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
