import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/course.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoursesNotifier with ChangeNotifier {
  List<Course> _items = [];
  CoursesNotifier(this._items);

  List<Course> get getCourses {
    return [..._items];
  }

  Course findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetCourses() async {
    const filterString = '/api/v1/course/list';
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

      _items = courses;
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
