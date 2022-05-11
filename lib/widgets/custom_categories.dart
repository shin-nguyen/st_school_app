import 'package:flutter/material.dart';
import 'package:st_school_app/models/category.dart';
import 'package:st_school_app/screens/shop/shop_page.dart';
import 'package:st_school_app/widgets/custom_categories_button.dart';

class CustomCategories extends StatelessWidget {
  CustomCategories({
    Key? key,
    required this.list,
  }) : super(key: key);

  List<Category> list;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(list.length, (index) {
        return Padding(
            padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
            child: CustomCategoriesButton(
              title: list[index].title,
              route: ShopPage.routeName,
              arg: list[index].title,
            ));
      }),
    );
  }
}
