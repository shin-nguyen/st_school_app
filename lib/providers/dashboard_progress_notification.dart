import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:st_school_app/models/dashboard_progress.dart';
import 'package:st_school_app/models/video.dart';

class DashboardProgressNotifier with ChangeNotifier {
  List<DashboardProgress> _items = [];

  DashboardProgressNotifier(this._items);

  List<DashboardProgress> get getDashboardProgress {
    return [..._items];
  }

  Future<void> fetchAndSetDashboardProgress() async {
    const filterString = '/api/v1/users/dashboard-progress';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get("token").toString();
    try {
      final response =
          await http.get(Uri.parse(baseUrl + filterString), headers: {
        "Authorization": token,
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      final dataJson = (json.decode(response.body));
      final List<DashboardProgress> progresses = [];

      progresses.add(
        DashboardProgress(
            color: [secondary, primary], count: dataJson['sun'], day: "Sun"),
      );

      progresses.add(
        DashboardProgress(
            color: [fourthColor, thirdColor],
            count: dataJson['mon'],
            day: "Mon"),
      );
      progresses.add(
        DashboardProgress(
            color: [secondary, primary], count: dataJson['tue'], day: "Tue"),
      );
      progresses.add(
        DashboardProgress(
            color: [fourthColor, thirdColor],
            count: dataJson['wed'],
            day: "Wed"),
      );
      progresses.add(
        DashboardProgress(
            color: [secondary, primary], count: dataJson['thu'], day: "Thu"),
      );
      progresses.add(
        DashboardProgress(
            color: [fourthColor, thirdColor],
            count: dataJson['fri'],
            day: "Fri"),
      );
      progresses.add(
        DashboardProgress(
            color: [secondary, primary], count: dataJson['sat'], day: "Sat"),
      );

      _items = progresses;
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
