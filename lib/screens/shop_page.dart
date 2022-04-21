import 'package:flutter/material.dart';
import 'package:st_school_app/widgets/appbar.dart';
import 'package:st_school_app/widgets/course_list.dart';
import 'package:st_school_app/widgets/sorting.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      const CustomeAppBar(),
      const SizedBox(
        height: 20,
      ),
      const Sorting(),
      const CourseList()
    ])));
  }
}
