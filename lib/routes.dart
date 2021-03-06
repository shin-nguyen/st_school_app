import 'package:flutter/widgets.dart';
import 'package:st_school_app/screens/categories/categories_page.dart';
import 'package:st_school_app/screens/checkout/cart_page.dart';
import 'package:st_school_app/screens/detail/detail_page.dart';
import 'package:st_school_app/screens/edit_profile/edit_profile_page.dart';
import 'package:st_school_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:st_school_app/screens/home/blog/components/blog_details_page.dart';
import 'package:st_school_app/screens/home/main_page.dart';
import 'package:st_school_app/screens/payment/payment_page.dart';

import 'screens/learning/my-learnings-page.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  MainPage.routeName: (context) => const MainPage(),
  EditProfilePage.routeName: (context) => const EditProfilePage(),
  BlogDetailsPage.routeName: (context) => const BlogDetailsPage(),
  DetailPage.routeName: (context) => DetailPage(),
  CategoriesPage.routeName: (context) => const CategoriesPage(),
  LearningPage.routeName: (context) => const LearningPage(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  CartPage.routeName: (context) => const CartPage(),
  PaymentPage.routeName: (context) => const PaymentPage(),
};
