import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/category.dart';
import 'package:st_school_app/providers/cart_notifier.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
import 'package:st_school_app/screens/checkout/checkout_page.dart';
import 'package:st_school_app/screens/home/home-page/components/home.dart';
import 'package:st_school_app/widgets/appbar.dart';
import 'package:st_school_app/widgets/badge.dart';
import 'package:st_school_app/widgets/category_list.dart';
import 'package:st_school_app/widgets/custom_categories_button.dart';
import 'package:st_school_app/widgets/custom_promotion_card.dart';
import 'package:st_school_app/widgets/custom_title.dart';
import 'package:st_school_app/widgets/custome_search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<CoursesNotifier>(context).fetchAndSetCourses().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Consumer<CartNotifier>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
              color: Colors.tealAccent,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CheckoutPage.routeName);
              },
            ),
          ),
        ],
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // const CustomeAppBar(),

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

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const Text(
                  //       "Categories",
                  //       style: TextStyle(
                  //         fontSize: 24,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //     InkWell(
                  //       onTap: () => {Navigator.pushNamed(context, '/shop')},
                  //       child: const Text(
                  //         "See More",
                  //         style: TextStyle(fontSize: 16, color: kblue),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  //categories
                  const Padding(
                    padding:
                        EdgeInsets.only(left: appPadding, right: appPadding),
                    child: CustomTitle(title: 'Categories'),
                  ),
                  const SizedBox(height: smallSpacer),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                      left: appPadding,
                      right: appPadding - 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: List.generate(categoryJson.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, bottom: 10.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: CustomCategoriesButton(
                                    title: categoryJson[index].title),
                              ),
                            );
                          }),
                        ),
                        Row(
                            children:
                                List.generate(categoryJson.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, bottom: 10.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: CustomCategoriesButton(
                                  title: categoryJsonTwo[index].title),
                            ),
                          );
                        })),
                        // ),
                      ],
                    ),
                  ),

                  //now we create model of our images and colors which we will use in our app
                  const SizedBox(
                    height: 20,
                  ),
                  //we can not use gridview inside column
                  //use shrinkwrap and physical scroll

                  // const CategoryList(),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomTitle(title: 'Design Courses'),
                  const SizedBox(height: smallSpacer),
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const HomeGrid()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
