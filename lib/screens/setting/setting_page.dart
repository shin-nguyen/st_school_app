import 'package:flutter/material.dart';

import 'components/body.dart';

class SettingPage extends StatelessWidget {
  static String routeName = "/setting";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
