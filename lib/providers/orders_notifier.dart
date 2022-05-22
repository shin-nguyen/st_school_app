import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/course.dart';
import 'package:st_school_app/models/order.dart';

class OrdersNotifier with ChangeNotifier {
  OrderItem _orders;

  OrdersNotifier(this._orders);

  OrderItem get orders {
    return _orders;
  }

  double get totalOrder {
    double total = 0;
    for (var course in _orders.courses) {
      if (course.subPrice != 0) {
        total += course.subPrice;
      } else {
        total += course.price;
      }
    }
    return total;
  }

  Future<void> addOrder(List<Course> courses) async {
    const filterString = '/api/v1/order/adds';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get("token").toString();

    try {
      final response = await http.post(
        Uri.parse(baseUrl + filterString),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode({
          'courses': courses
              .map((course) => {
                    'id': course.id,
                  })
              .toList(),
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 400) {
        _orders = OrderItem(courses: courses);
        notifyListeners();
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (error) {
      rethrow;
    }
    notifyListeners();
  }
}
