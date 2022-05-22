import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/course.dart';

class SearchItemPage extends StatelessWidget {
  const SearchItemPage({
    Key? key,
    required this.course,
  }) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Container(
      height: w * 0.3,
      width: w - 10,
      padding: const EdgeInsets.only(top: 12, left: 12),
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
                color: Color(0x0000ffd8),
                offset: Offset(1, 1),
                blurRadius: 20.0,
                spreadRadius: 10)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: w * .14,
            child: Row(
              children: [
                SizedBox(
                  height: w * .18,
                  width: w * .13,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      course.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: miniSpacer),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: secondary,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: miniSpacer),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Intructor: ' + course.lecturer,
                            style: const TextStyle(
                              fontSize: 11.0,
                              color: grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 0.2,
          // ),
          Row(
            children: [
              SizedBox(
                width: w * .16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: w * 0.35,
                  ),
                  child: const Text(
                    '(4.7) ',
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
                SizedBox(
                  width: w * .16,
                ),
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
        ],
      ),
    );
  }
}
