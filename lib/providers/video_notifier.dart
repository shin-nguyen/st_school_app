import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:st_school_app/models/video.dart';

class VideosNotifier with ChangeNotifier {
  List<Video> _items = [];

  VideosNotifier(this._items);

  List<Video> get getVideos {
    return [..._items];
  }

  List<Video> getByCourse(int id) {
    return _items.where((video) => video.course == id).toList();
  }

  Video findById(int id) {
    return _items.firstWhere((course) => course.id == id,
        orElse: () => Video.empty());
  }

  Future<void> fetchAndSetVideos() async {
    const filterString = '/api/v1/video/list';

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
      final List<Video> videos = [];

      dataJson.forEach((video) {
        videos.add(Video.fromJson(video));
      });

      _items = videos;
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
