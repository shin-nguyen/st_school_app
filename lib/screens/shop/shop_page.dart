import 'package:flutter/material.dart';
import 'package:st_school_app/screens/shop/components/course_list.dart';
import 'package:st_school_app/widgets/appbar.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  static const routeName = '/shop';
  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 230, 230, 230)),
            child: ListView(children: [
              CustomeAppBar(),
              const SizedBox(
                height: 20,
              ),
              // Sorting(),
              CourseList()
            ])));
  }
}
