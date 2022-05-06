import 'package:flutter/material.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/course.dart';
import 'package:st_school_app/widgets/appbar.dart';
import 'package:st_school_app/widgets/category_list.dart';
import 'package:st_school_app/widgets/custom_category_card.dart';
import 'package:st_school_app/widgets/custom_course_card.dart';
import 'package:st_school_app/widgets/custom_promotion_card.dart';
import 'package:st_school_app/widgets/custom_title.dart';
import 'package:st_school_app/widgets/custome_search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const CustomeAppBar(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Hi Sinh Nguyen",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Today is a good day\nto learn something new!",
                            style: TextStyle(
                              color: Colors.black54,
                              wordSpacing: 2.5,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                color: kpurple,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Image.asset(
                              "./assets/images/profile.png",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //search
                  const SizedBox(height: spacer),
                  const CustomSearchField(
                    hintField: 'Try "Web Design"',
                    backgroundColor: background,
                  ),
                  const SizedBox(height: spacer - 30.0),
                  //categoy card
                  // const CustomCategoryCard(),
                  //promotion card
                  const CustomPromotionCard(),
                  const SizedBox(height: spacer),
                  //category list
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () => {Navigator.pushNamed(context, '/shop')},
                        child: const Text(
                          "See More",
                          style: TextStyle(fontSize: 16, color: kblue),
                        ),
                      ),
                    ],
                  ),

                  //now we create model of our images and colors which we will use in our app
                  const SizedBox(
                    height: 20,
                  ),
                  //we can not use gridview inside column
                  //use shrinkwrap and physical scroll
                  const CategoryList(),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomTitle(title: 'Design Courses'),
                  const SizedBox(height: smallSpacer),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(
                      left: appPadding,
                      right: appPadding - 10.0,
                    ),
                    child: Wrap(
                      children: List.generate(courses.length, (index) {
                        var data = courses[index];

                        return Padding(
                          padding:
                              const EdgeInsets.only(right: 15.0, bottom: 20.0),
                          child: GestureDetector(
                            child: CustomCourseCardExpand(
                              thumbNail: data.image,
                              videoAmount: data.videoTotal.toString(),
                              title: data.description,
                              userProfile:
                                  'https://images.unsplash.com/photo-1601582589907-f92af5ed9db8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1064&q=80',
                              userName: data.lecturer,
                              price: data.price.toString(),
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
