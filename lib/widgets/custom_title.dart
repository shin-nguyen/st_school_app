import 'package:flutter/material.dart';
import 'package:st_school_app/constants/system_constants.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    Key? key,
    required this.title,
    this.route = '/404',
    this.extend = true,
    this.fontSize = 20.0,
    this.arg,
  }) : super(key: key);

  final String title;
  final String route;
  final bool extend;
  final double fontSize;
  final arg;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: secondary,
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            (extend)
                ? GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        route,
                        arguments: arg,
                      );
                    },
                    child: const Text(
                      'See More',
                      style: TextStyle(
                          color: primary,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                : Container(),
          ],
        ));
  }
}
