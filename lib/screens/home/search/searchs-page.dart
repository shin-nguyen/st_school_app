import 'package:flutter/material.dart';
import 'package:st_school_app/constants/system_constants.dart';
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
          const CustomSearchField(
            hintField: 'Try "Web Design"',
            backgroundColor: textWhite,
          ),
          const SizedBox(height: spacer),

          //title
          const CustomTitle(title: 'Top Searches', extend: false),
          const SizedBox(height: smallSpacer),

          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: List.generate(categoryJson.length, (index) {
              return Container(
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
              );
            }),
          ),

          //title
          const CustomTitle(title: 'Categories', extend: false),
          const SizedBox(height: smallSpacer),

          //list categories
          Column(
            children: List.generate(allCategories.length, (index) {
              var data = allCategories[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: miniSpacer),
                child: GestureDetector(
                  onTap: () {},
                  child: CunstomPlaceHolder(
                    title: data.title,
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
