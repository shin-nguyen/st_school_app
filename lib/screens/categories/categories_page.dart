import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/course.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
import 'package:st_school_app/screens/categories/components/categories_grid.dart';
import 'package:st_school_app/widgets/custom_title.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  static const routeName = '/category_page';
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
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
        ),
        body: SafeArea(
            child: ListView(children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomTitle(
              title: type == '' ? "Categories" : type,
              fontSize: 30,
              extend: false,
            ),
          ),
          const SizedBox(height: appPadding),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomTitle(
              title: "Course to get you started",
              fontSize: 25,
              extend: false,
            ),
          ),
          const SizedBox(height: miniSpacer),
          courses == []
              ? Container()
              : CategoriesGrid(
                  courses: courses!,
                )
        ])));
  }
}
