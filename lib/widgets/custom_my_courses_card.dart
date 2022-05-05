import 'package:flutter/material.dart';
import 'package:st_school_app/constants/system_constants.dart';

class CustomMyCoursesCard extends StatefulWidget {
  const CustomMyCoursesCard({
    Key? key,
    required this.image,
    required this.title,
    required this.instructor,
    required this.videoAmount,
    this.percentage = 0,
  }) : super(key: key);

  final String image;
  final String title;
  final String instructor;
  final String videoAmount;
  final double percentage;

  @override
  _CustomMyCoursesCardState createState() => _CustomMyCoursesCardState();
}

class _CustomMyCoursesCardState extends State<CustomMyCoursesCard> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Container(
      width: w,
      height: w * .3,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: textWhite,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: w * .13,
            child: Row(
              children: [
                SizedBox(
                  height: w * .13,
                  width: w * .13,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: miniSpacer),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: secondary,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Intructor: ' + widget.instructor,
                            style: const TextStyle(
                              fontSize: 11.0,
                              color: grey,
                            ),
                          ),
                          Text(
                            '6/' + widget.videoAmount,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: w,
                      height: 5.0,
                      decoration: BoxDecoration(
                        color: secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    Container(
                      width: widget.percentage * 2.8,
                      height: 7.0,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(100.0),
                        boxShadow: [
                          BoxShadow(
                            color: primary.withOpacity(0.5),
                            blurRadius: 6.0,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: miniSpacer * 2),
              Container(
                width: 50,
                alignment: Alignment.centerRight,
                child: Text(
                  widget.percentage.toString() + '%',
                  style: const TextStyle(
                      fontSize: 13.0,
                      color: primary,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
