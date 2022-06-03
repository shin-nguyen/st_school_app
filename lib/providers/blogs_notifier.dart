import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/blog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BlogsNotifier with ChangeNotifier {
  List<Blog> _items = [];
  List<Blog> _itemSearch = [];

  BlogsNotifier(
    this._items,
    this._itemSearch,
  );

  List<Blog> get getBlogs {
    _itemSearch = _items;
    return [..._items];
  }

  List<Blog> get getSearch {
    return [..._itemSearch];
  }

  Blog findById(int id) {
    return _items.firstWhere((blog) => blog.id == id,
        orElse: () => Blog.empty());
  }

  Future<void> findByQuery(String query) async {
    query = query.toLowerCase();
    try {
      _itemSearch = query == ''
          ? _items
          : _items.where((blog) {
              final name = blog.title.toLowerCase();
              return name.contains(query);
            }).toList();

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateLike(int blogId) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == blogId);
    if (prodIndex >= 0) {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.get("token").toString();

      final response = await http.put(
          Uri.parse(baseUrl + '/api/v1/blogs/love/' + blogId.toString()),
          headers: {
            "Authorization": token,
            "Content-Type": "application/json",
            "Accept": "application/json"
          });

      if (response.statusCode == 200) {
        _items[prodIndex].love = !_items[prodIndex].love;
        _items[prodIndex].recordLove =
            (json.decode(response.body) as List).length;
        notifyListeners();
      } else {
        throw Exception('Failed to load data!');
      }
    }
  }

  Future<void> fetchAndSetBlogs() async {
    const filterString = '/api/v1/blogs/user-love';
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
      final List<Blog> blogs = [];

      for (var blog in dataJson) {
        blogs.add(
          Blog.fromJson(blog),
        );
      }
      _items = blogs;
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
