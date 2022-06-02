import 'package:flutter/material.dart';

const kpink = Color(0xFFff6374);
const kblue = Color(0xFF71b8ff);
const kpurple = Color(0xFF9ba0fc);
const korange = Color(0xFFffaa5b);

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),
  );
}

const double appPadding = 25.0;
const double spacer = 50.0;
const double smallSpacer = 30.0;
const double miniSpacer = 10.0;

const Color primary = Color(0xFF2EA5FF);
const Color secondary = Color(0xFF132342);
const Color background = Color(0xFFF5F5F5);
const Color textWhite = Color(0xFFFFFFFF);
const Color textBlack = Color(0xFF000000);
const Color grey = Color(0xFF707070);
const Color idColor = Color(0xFF9ca2ac);
const String assetImg = 'assets/images/';

const Color thirdColor = Color(0xFFC58BF2);
const Color fourthColor = Color(0xFFEEA4CE);
const Color bgTextField = Color(0xFFF7F8F8);

const Color facebookColor = Color(0xFF3b5998);
const Color googleColor = Color(0xFFDB4437);

const String branchIoDeepLink = "Generate Branch IO Deep Link";
const String deepLinkTitle = "deep_link_title";
const String clickedBranchLink = "+clicked_branch_link";
const String controlParamsKey = '\$uri_redirect_mode';
const String deepLinkData = 'flutter deep link';
const String branchIoCanonicalIdentifier = 'flutter/branch';
const String nextScreenAppBarTitle = "Data From Branch Io";
const String homeScreenAppBarTitle = "Generate Branch IO";
const String gettingData = "Getting Data";
const String appTitle = 'Deep Link With Flutter';

const String baseUrl = "http://192.168.1.26:8080";
