import 'package:flutter/material.dart';
import 'package:st_school_app/models/product_model.dart';

class CourseList extends StatelessWidget {
  const CourseList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.85),
        itemBuilder: (context, index) => CourseCard(
              product: products[index],
            ));
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key key,
    this.product,
  }) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
          onTap: () => Navigator.pushNamed(context, '/detail/1'),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: product.color,
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              children: [
                Image.asset(
                  product.image,
                  height: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  product.title,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${product.courses} courses",
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
