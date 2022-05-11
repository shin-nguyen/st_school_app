import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/category.dart';
import 'package:st_school_app/providers/cart_notifier.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
import 'package:st_school_app/providers/user_notifier.dart';
import 'package:st_school_app/screens/checkout/checkout_page.dart';
import 'package:st_school_app/screens/home/home-page/components/home.dart';
import 'package:st_school_app/screens/home/home-page/components/user_info.dart';
import 'package:st_school_app/screens/shop/shop_page.dart';
import 'package:st_school_app/widgets/appbar.dart';
import 'package:st_school_app/widgets/badge.dart';
import 'package:st_school_app/widgets/category_list.dart';
import 'package:st_school_app/widgets/custom_categories.dart';
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

      Provider.of<UserNotifier>(context).getInfoByToken();
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // Create Cart
            Consumer<CartNotifier>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString(),
                color: primary,
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
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const UserInfo(),
                  //search
                  const SizedBox(height: spacer - 30.0),
                  //promotion card
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const CustomPromotionCard(),
                  const SizedBox(height: spacer),
                  const CustomTitle(
                    title: 'Categories',
                    route: ShopPage.routeName,
                    arg: "",
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
                        CustomCategories(list: categoryJson),
                        CustomCategories(list: categoryJsonTwo),
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
