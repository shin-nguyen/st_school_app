import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/course.dart';

class CourseStarCard extends StatelessWidget {
  const CourseStarCard({
    Key? key,
    required this.course,
  }) : super(key: key);
  final Course course;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: w,
          height: h * 0.28, //??
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(course.image),
              fit: BoxFit.fill,
            ),
            boxShadow: [
              BoxShadow(
                color: textBlack.withOpacity(0.1),
                blurRadius: 10.0,
                offset: const Offset(0, 5),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: w,
            ),
            child: Text(course.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  color: textBlack,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: w,
            ),
            child: Text(
              course.lecturer,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 18.0),
            ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: w * 0.35,
                ),
                child: const Text(
                  '(4.7)',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            RatingBarIndicator(
              rating: 3.5,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              unratedColor: Colors.grey,
              itemCount: 5,
              itemSize: 18.0,
              direction: Axis.horizontal,
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text('(${course.subTotal})',
                  style: const TextStyle(
                    color: textBlack,
                    fontSize: 14.0,
                  )),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            children: [
              // const Icon(
              //   FontAwesomeIcons.dollarSign,
              //   color: textBlack,
              //   size: 15,
              // ),
              Text(
                '\$' +
                    (course.subPrice != 0
                        ? course.subPrice.toString()
                        : course.price.toString()),
                style: const TextStyle(
                    color: textBlack,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800),
              ),
              course.subPrice != 0
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                text: '\$' + course.price.toString(),
                              ),
                            ],
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey.shade500,
                                fontSize: 14.0)),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
        // courseData[index]['bestseller']
        //     ? Padding(
        //         padding: const EdgeInsets.only(top: 4.0, left: 2),
        //         child: Container(
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(5),
        //               color: Colors.yellow[300],
        //             ),
        //             child: Padding(
        //               padding: const EdgeInsets.symmetric(
        //                   horizontal: 8.0, vertical: 5.0),
        //               child: Text('Bestseller',
        //                   style: TextStyle(
        //                       color: Colors.brown,
        //                       fontWeight: FontWeight.bold)),
        //             )),
        //       )
        //     : Container(),
      ],
    );
  }
}
