import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
import 'package:st_school_app/screens/detail/detail_page.dart';

class CustomPromotionCard extends StatelessWidget {
  const CustomPromotionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final promotion = Provider.of<CoursesNotifier>(context).findOne();

    var size = MediaQuery.of(context).size;
    return promotion.title == ''
        ? Container()
        : Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: size.width,
                  height: size.width * .425,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: secondary,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        promotion.title.toString(),
                        style: const TextStyle(
                          fontSize: 25.0,
                          color: textWhite,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 7.0),
                      SizedBox(
                        width: size.width * .425,
                        child: Text(
                          promotion.subTitle.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: textWhite,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                          height: 35.0,
                          width: 100.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primary.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(100.0),
                            boxShadow: [
                              BoxShadow(
                                color: primary.withOpacity(0.5),
                                spreadRadius: 0.0,
                                blurRadius: 6.0,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                DetailPage.routeName,
                                arguments: promotion.id,
                              );
                            },
                            child: const Text(
                              'Enroll Now',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: textWhite,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                Positioned(
                  top: -20.0,
                  right: 20.0,
                  child: SizedBox(
                    height: size.width * .4,
                    child: SvgPicture.asset(
                      promotion.image.toString(),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
