import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/providers/courses.dart';
import 'package:st_school_app/screens/home/main_page.dart';
import 'home/main_page.dart';

// import '../widgets/app_drawer.dart';
// import '../widgets/products_grid.dart';
// import '../widgets/badge.dart';
// import '../providers/cart.dart';
// import './cart_screen.dart';
// import '../providers/products.dart';

enum FilterOptions {
  Favorites,
  All,
}

class CoursesOverviewScreen extends StatefulWidget {
  @override
  _CoursesOverviewScreenState createState() => _CoursesOverviewScreenState();
}

class _CoursesOverviewScreenState extends State<CoursesOverviewScreen> {
  // var _showOnlyFavorites = false;
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
      Provider.of<Courses>(context).fetchAndSetCourses().then((_) {
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : MainPage(),
    );
  }
}
