import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/category.dart';

class CustomCategoryCard extends StatelessWidget {
  const CustomCategoryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(homePageCategoryJson.length, (index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              height: size.width * .25,
              width: size.width * .25,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: textWhite,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: textBlack.withOpacity(0.05),
                    blurRadius: 15.0,
                    offset: const Offset(0, 7),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 35.0,
                    width: 35.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: primary.withOpacity(0.5),
                          spreadRadius: 0.0,
                          blurRadius: 6.0,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: SvgPicture.asset(
                      homePageCategoryJson[index].icon,
                      color: textWhite,
                      width: 15.0,
                    ),
                  ),
                  Text(
                    homePageCategoryJson[index].title,
                    style: const TextStyle(
                      color: secondary,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 0.0),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
