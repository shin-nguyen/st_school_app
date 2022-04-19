import 'package:flutter/cupertino.dart';
import 'package:st_school_app/models/course.dart';

class Courses with ChangeNotifier {
  final List<Course> _items = [
    const Course(
        id: 1,
        name: 'name',
        description: 'description',
        lecturer: 'lecturer',
        language: 'language',
        price: 122,
        image:
            "https://res.cloudinary.com/qscloud/image/upload/v1638543961/st-school/images/js.png.png",
        subTotal: 1,
        videoTotal: 1),
    const Course(
        id: 1,
        name: 'name',
        description: 'description',
        lecturer: 'lecturer',
        language: 'language',
        price: 122,
        image:
            "https://res.cloudinary.com/qscloud/image/upload/v1638543915/st-school/images/py.png.png",
        subTotal: 1,
        videoTotal: 1),
    const Course(
        id: 1,
        name: 'name',
        description: 'description',
        lecturer: 'lecturer',
        language: 'language',
        price: 122,
        image:
            "https://res.cloudinary.com/qscloud/image/upload/v1632104647/st-school/images/java.png.png",
        subTotal: 1,
        videoTotal: 1)
  ];

  List<Course> get getCourses {
    return [..._items];
  }

  void addCourse() {
    // _items.add(value);
    notifyListeners();
  }
}
