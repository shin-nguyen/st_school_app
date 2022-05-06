import 'package:flutter/material.dart';
import 'package:st_school_app/models/category.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: homeCategories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.85),
        itemBuilder: (context, index) => CategoryCard(
              category: homeCategories[index],
            ));
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
          onTap: () => Navigator.pushNamed(context, '/shop'),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: category.color,
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              children: [
                Image.asset(
                  category.icon,
                  height: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  category.title,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${category.courses} courses",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
