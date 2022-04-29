import 'package:flutter/material.dart';
import 'package:st_school_app/models/course.dart';

class CourseList extends StatelessWidget {
  const CourseList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: courses.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.85),
        itemBuilder: (context, index) => CourseCard(
              course: courses[index],
            ));
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.course,
  }) : super(key: key);
  final Course course;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
            onTap: () => Navigator.pushNamed(context, '/detail'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                decoration: new BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: ClipRRect(
                        // borderRadius: BorderRadius.circular(10.0),
                        child: Positioned(
                            child: Container(
                          width: double.maxFinite,
                          height: 130,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://res.cloudinary.com/qscloud/image/upload/v1635049180/st-school/images/html.png.png"),
                                  fit: BoxFit.cover)),
                        )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: SizedBox(
                        width: 200.0,
                        child: Text(
                          course.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromARGB(255, 31, 1, 1),
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 3.0),
                      child: Text(
                        course.lecturer,
                        style: TextStyle(
                          color: Color.fromARGB(255, 102, 102, 102),
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18.0,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18.0,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18.0,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18.0,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 18.0,
                          ),
                          // Text(
                          //   "4",
                          //   style: TextStyle(
                          //     color: Color.fromARGB(255, 17, 14, 14),
                          //     fontSize: 14.0,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         "" != "" ? "" : "",
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 18.0,
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         width: 7.0,
                    //       ),
                    //       Text(
                    //         "" != "" ? "" : "",
                    //         style: TextStyle(
                    //           color: Colors.grey,
                    //           fontSize: 15.0,
                    //           decoration: TextDecoration.lineThrough,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 5.0),
                      child: SizedBox(
                        child: Text(
                          "\$ " + course.price.toString(),
                          style: TextStyle(
                              color: Color.fromARGB(255, 8, 8, 8),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
