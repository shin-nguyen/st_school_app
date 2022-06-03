import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/course.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
import 'package:st_school_app/screens/categories/components/categories_grid.dart';
import 'package:st_school_app/screens/home/search/components/search-item.dart';
import 'package:st_school_app/widgets/custom_title.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  static const routeName = '/category-page';
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    final type =
        ModalRoute.of(context)?.settings.arguments as String; // is the id!
    final List<Course>? coursesBegin = Provider.of<CoursesNotifier>(
      context,
      listen: false,
    ).findByCatogoryBegin(type);

    final List<Course>? courses = Provider.of<CoursesNotifier>(
      context,
      listen: false,
    ).findByCatogory(type);

    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        titleSpacing: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          type == '' ? "Categories" : type,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: textBlack,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: appPadding),
            coursesBegin!.isEmpty
                ? Container()
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: CustomTitle(
                      title: "Course to get you started",
                      fontSize: 25,
                      extend: false,
                    ),
                  ),
            const SizedBox(height: miniSpacer),
            coursesBegin.isEmpty
                ? Container()
                : CategoriesGrid(
                    courses: coursesBegin,
                  ),
            const SizedBox(height: smallSpacer),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: CustomTitle(
                title: "All Course",
                fontSize: 25,
                extend: false,
              ),
            ),
            Column(
              children: List.generate(
                courses!.length,
                (index) {
                  final courseSearch = courses[index];
                  return SearchItemPage(course: courseSearch);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
