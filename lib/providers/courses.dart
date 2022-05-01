import 'package:flutter/cupertino.dart';
import 'package:st_school_app/models/course.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../constants/base_constants.dart' as Constants;

class Courses with ChangeNotifier {
  List<Course> _items = [
    //   const Course(
    //       id: 1,
    //       name: 'name',
    //       description: 'description',
    //       lecturer: 'lecturer',
    //       language: 'language',
    //       price: 122,
    //       image:
    //           "https://res.cloudinary.com/qscloud/image/upload/v1638543961/st-school/images/js.png.png",
    //       subTotal: 1,
    //       videoTotal: 1),
    //   const Course(
    //       id: 1,
    //       name: 'name',
    //       description: 'description',
    //       lecturer: 'lecturer',
    //       language: 'language',
    //       price: 122,
    //       image:
    //           "https://res.cloudinary.com/qscloud/image/upload/v1638543915/st-school/images/py.png.png",
    //       subTotal: 1,
    //       videoTotal: 1),
    //   const Course(
    //       id: 1,
    //       name: 'name',
    //       description: 'description',
    //       lecturer: 'lecturer',
    //       language: 'language',
    //       price: 122,
    //       image:
    //           "https://res.cloudinary.com/qscloud/image/upload/v1632104647/st-school/images/java.png.png",
    //       subTotal: 1,
    //       videoTotal: 1)
    //
  ];
  List<Course> _orders = [];

  String authToken;
  Courses(this.authToken, this._items);

  List<Course> get getCourses {
    return [..._items];
  }

  List<Course> get getOrder {
    return [..._orders];
  }

  Course findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetCourses([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? '/api/v1/course/purchased' : '/api/v1/course/list';

    var url = Uri.parse(Constants.BASE_URL + filterString);
    try {
      final response = await http.get(url, headers: {
        "Authorization": authToken,
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      final coursesJson = json.decode(response.body);
      final List<Course> courses = [];

      coursesJson.forEach((course) {
        courses.add(Course(
          id: 1,
          name: course['name'],
          description: course['description'],
          price: course['price'],
          language: course['language'],
          image: course['image'],
          lecturer: "1",
          subTotal: 1,
          videoTotal: 1,
        ));
      });

      if (filterByUser) {
        _items = courses;
      } else {
        _orders = courses;
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void clear() {
    _items = [];
    notifyListeners();
  }
}
