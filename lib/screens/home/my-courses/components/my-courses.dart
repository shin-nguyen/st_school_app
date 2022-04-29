import 'package:flutter/material.dart';
import 'package:st_school_app/models/course.dart';
import 'package:st_school_app/screens/learning/learning_page.dart';

class MyCourseList extends StatelessWidget {
  const MyCourseList({
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
            onTap: () => Navigator.pushNamed(context, LearningPage.routeName),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                decoration: new BoxDecoration(
                    color: Color.fromARGB(255, 248, 247, 247)),
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
                      padding: const EdgeInsets.only(left: 10.0, top: 10),
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
                      padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Text(
                        course.lecturer,
                        style: TextStyle(
                          color: Color.fromARGB(255, 102, 102, 102),
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    Padding(
                        padding:
                            EdgeInsets.only(left: 10.0, top: 10.0, right: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const LinearProgressIndicator(
                                minHeight: 8,
                                backgroundColor:
                                    Color.fromARGB(255, 224, 225, 225),
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red),
                                value: 0.10,
                              ),
                              Text('${(0.10 * 100).round()}%')
                            ])),
                  ],
                ),
              ),
            )));
  }
}
