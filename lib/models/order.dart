import 'package:st_school_app/models/course.dart';

class OrderItem {
  final List<Course> courses;
  OrderItem({
    required this.courses,
  });

  factory OrderItem.empty() {
    return OrderItem(courses: <Course>[Course.empty()]);
  }
}
