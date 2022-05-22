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
  List<Course> _itemSearch = [];

  CoursesNotifier(
    this._items,
    this._promotions,
    this._myLearning,
  );

  List<Course> get getCourses {
    return [..._items];
  }

  List<Course> get getMyLearning {
    return [..._myLearning];
  }

  List<Course> get getSearch {
    return [..._itemSearch];
  }

  List<Promotion> get getPromotions {
    return [..._promotions];
  }

  Course findById(int id) {
    return _items.firstWhere((course) => course.id == id,
        orElse: () => Course.empty());
  }

  Course findByMeLearning(int id) {
    return _myLearning.firstWhere((course) => course.id == id,
        orElse: () => Course.empty());
  }

  List<Course>? findByCatogory(String type) {
    return type == ''
        ? _items
        : _items.where((prod) => prod.topic == type).toList();
  }

  Future<void> findByQuery(String query) async {
    try {
      _itemSearch = query == ''
          ? _items
          : _items.where((course) {
              final name = course.name.toLowerCase();
              return name.contains(query);
            }).toList();

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Promotion findOne() {
    if (_promotions.isEmpty) {
      return Promotion.empty();
    }

    final _random = Random();
    return _promotions[_random.nextInt(_promotions.length)];
  }

  Future<void> fetchAndSetCourses([bool myLearning = false]) async {
    final filterString =
        !myLearning ? '/api/v1/course/list' : '/api/v1/order/by-user';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get("token").toString();
    try {
      final response =
          await http.get(Uri.parse(baseUrl + filterString), headers: {
        "Authorization": token,
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      final dataJson = json.decode(response.body);

      if (!myLearning) {
        final List<Course> courses = [];

        dataJson.forEach((course) {
          courses.add(Course.fromJson(course));
        });
        final List<Promotion> promotions = [];

        //Get promotion from courses
        for (var course in courses) {
          if (course.price > course.subPrice && course.subPrice != 0) {
            promotions.add(Promotion(
              course.id,
              'assets/images/dog_reading_vector.svg',
              'Get ${((course.price - course.subPrice) / course.price * 100).round()}% Off',
              course.description,
            ));
          }
        }
        _items = courses;
        _itemSearch = courses;
        _promotions = promotions;
      } else {
        final List<Course> courses = [];

        for (var order in dataJson) {
          courses.add(Course.fromOrder(order['course'], order['progress'],
              (order['videos'] as List).length));
        }
        _myLearning = courses;
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void clear() {
    _items = [];
    _itemSearch = [];
    notifyListeners();
  }
}
