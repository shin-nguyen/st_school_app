import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/course.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
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
    final type =
        ModalRoute.of(context)?.settings.arguments as String; // is the id!
    final List<Course>? courses = Provider.of<CoursesNotifier>(
      context,
      listen: false,
    ).findByCatogory(type);

    return Scaffold(
        backgroundColor: background,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            type == '' ? "Categories" : type,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        body: GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: courses!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.85),
            itemBuilder: (context, index) => CourseCard(
                  course: courses[index],
                )));
  }
}
