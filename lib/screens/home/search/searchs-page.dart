import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/screens/home/my-courses/components/my-courses.dart';
import 'package:st_school_app/utils/app_color.dart';
import 'package:st_school_app/widgets/categories_search.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:st_school_app/widgets/custom_heading.dart';
import 'package:st_school_app/widgets/custom_title.dart';
import 'package:st_school_app/widgets/custome_search_field.dart';

class SearchsPage extends StatefulWidget {
  const SearchsPage({Key? key}) : super(key: key);

  @override
  State<SearchsPage> createState() => _SearchsPageState();
}

class _SearchsPageState extends State<SearchsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.idColor,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(appPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(
            height: spacer - 1.0,
          ),

          //Header
          CustomHeading(
            title: "Explore",
            subTitle: "Seek for your preference",
            color: secondary,
          ),
          SizedBox(height: spacer),

          // search
          CustomSearchField(
            hintField: 'Try "Web Design"',
            backgroundColor: textWhite,
          ),
          SizedBox(height: spacer),

          //title
          CustomTitle(title: 'Top Searches', extend: false),
          SizedBox(height: smallSpacer),

          // Wrap(
          //   spacing: 10.0,

          // )
        ],
      ),
    );
  }
}
