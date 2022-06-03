import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationsNotifier with ChangeNotifier {
  // Notifications _items;

  // NotificationsNotifier(this._items);

  // Notifications get getNotification {
  //   return _items;
  // }

  Future<void> fetchAndSetNotification(String title, String mess) async {
    const filterString = '/api/v1/notification/token';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get("tokenNotification").toString();
    try {
      final response = await http.post(
        Uri.parse(baseUrl + filterString),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode({
          "title": title,
          "meseage": mess,
          "token": token,
        }),
      );
    } catch (error) {
      rethrow;
    }
  }
}
