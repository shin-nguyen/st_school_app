import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
import 'package:st_school_app/screens/categories/categories_page.dart';
import 'package:st_school_app/screens/home/search/components/search-item.dart';
import 'package:st_school_app/widgets/custom_heading.dart';
import 'package:st_school_app/widgets/custom_place_holder.dart';
import 'package:st_school_app/widgets/custom_title.dart';
import 'package:st_school_app/widgets/custome_search_field.dart';
import 'package:st_school_app/models/category.dart';

class SearchsPage extends StatefulWidget {
  const SearchsPage({Key? key}) : super(key: key);

  @override
  State<SearchsPage> createState() => _SearchsPageState();
}

class _SearchsPageState extends State<SearchsPage> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    final course = Provider.of<CoursesNotifier>(context);
    return Scaffold(
      // backgroundColor: AppColor.idColor,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: spacer - 1.0,
            ),

            //Header
            const CustomHeading(
              title: "Explore",
              subTitle: "Seek for your preference",
              color: secondary,
            ),
            const SizedBox(height: spacer),

            // search
            CustomSearchField(
              text: query,
              hintText: 'Search',
              onChanged: course.findByQuery,
            ),

            Column(
              children: List.generate(
                min(course.getSearch.length, 5),
                (index) {
                  final courseSearch = course.getSearch[index];
                  return SearchItemPage(course: courseSearch);
                },
              ),
            ),
            const SizedBox(height: spacer),
            //Top Searches
            const CustomTitle(title: 'Top Searches', extend: false),
            const SizedBox(height: smallSpacer),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: List.generate(categoryJson.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CategoriesPage.routeName,
                      arguments: categoryJson[index].title,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(100.0),
                      boxShadow: [
                        BoxShadow(
                          color: primary.withOpacity(0.5),
                          spreadRadius: 0.0,
                          blurRadius: 6.0,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Text(
                      categoryJson[index].title,
                      style: const TextStyle(
                        color: textWhite,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: smallSpacer),
            //Categories
            const CustomTitle(title: 'Categories', extend: false),
            const SizedBox(height: smallSpacer),

            //list categories
            Column(
              children: List.generate(categoryJson.length, (index) {
                var data = categoryJson[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: miniSpacer),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        CategoriesPage.routeName,
                        arguments: categoryJson[index].title,
                      );
                    },
                    child: CunstomPlaceHolder(
                      title: data.title,
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
