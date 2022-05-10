import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/course.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:st_school_app/models/promotion.dart';

class CoursesNotifier with ChangeNotifier {
  List<Course> _items = [];
  List<Course> _myLearning = [];
  List<Promotion> _promotions = [];

  CoursesNotifier(this._items, this._promotions, this._myLearning);

  List<Course> get getCourses {
    return [..._items];
  }

  List<Course> get getMyLearning {
    return [..._myLearning];
  }

  List<Promotion> get getPromotions {
    return [..._promotions];
  }

  Course findById(String id) {
    // ignore: unrelated_type_equality_checks
    return _items.firstWhere((prod) => prod.id == id);
  }

  Promotion findOne() {
    if (_promotions.isEmpty) {
      return Promotion.empty();
    }

    final _random = Random();
    return _promotions[_random.nextInt(_promotions.length)];
  }

  Future<void> fetchAndSetCourses([bool myLearning = true]) async {
    final filterString =
        !myLearning ? '/api/v1/course/list' : '/api/v1/course/list/purchased';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get("token").toString();
    try {
      final response =
          await http.get(Uri.parse(baseUrl + filterString), headers: {
        "Authorization": token,
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      final coursesJson = json.decode(response.body);
      final List<Course> courses = [];

      coursesJson.forEach((course) {
        courses.add(Course.fromJson(course));
      });

      if (!myLearning) {
        final List<Promotion> promotions = [];

        //Get promotion from courses
        for (var course in courses) {
          if (course.price > course.subPrice && course.subPrice != 0) {
            promotions.add(Promotion(
              'assets/images/dog_reading_vector.svg',
              'Get ${((course.price - course.subPrice) / course.price * 100).round()}% Off',
              course.description,
            ));
          }
        }
        _items = courses;
        _promotions = promotions;
        _myLearning = _myLearning;
      } else {
        _items = _items;
        _promotions = _promotions;
        _myLearning = courses;
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
