import 'package:flutter/widgets.dart';
import 'package:st_school_app/screens/checkout/checkout_page.dart';
import 'package:st_school_app/screens/detail/detail_page.dart';
import 'package:st_school_app/screens/edit_profile/edit_profile_page.dart';
import 'package:st_school_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:st_school_app/screens/home/main_page.dart';
import 'package:st_school_app/screens/learning/learning_page.dart';
import 'package:st_school_app/screens/shop/shop_page.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  MainPage.routeName: (context) => const MainPage(),
  EditProfilePage.routeName: (context) => const EditProfilePage(),
  DetailPage.routeName: (context) => const DetailPage(),
  ShopPage.routeName: (context) => const ShopPage(),
  LearningPage.routeName: (context) => const LearningPage(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  CheckoutPage.routeName: (context) => const CheckoutPage()
};
