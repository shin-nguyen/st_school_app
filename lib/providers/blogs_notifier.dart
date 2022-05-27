import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/blog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:st_school_app/utils/gql_parser.dart';

class BlogsNotifier with ChangeNotifier {
  List<Blog> _items = [];

  BlogsNotifier(
    this._items,
  );

  List<Blog> get getBlogs {
    return [..._items];
  }

  Blog findById(int id) {
    return _items.firstWhere((blog) => blog.id == id,
        orElse: () => Blog.empty());
  }

  Future<void> findByQuery(String query) async {
    try {
      _items = query == ''
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

  Future<void> fetchAndSetBlogs() async {
    const parser = GqlParser('graphql/');
    const filterString = '/api/v1/blogs/graphql/blogs';

    try {
      final response = await http.post(
        Uri.parse(baseUrl + filterString),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: parser.gqlRequestBody('blog-query', {'type': 'true'}),
      );

      final dataJson = jsonDecode(response.body)['data']['blogs'] as List;
      final List<Blog> blogs = [];

      dataJson.forEach((course) {
        blogs.add(Blog.fromJson(course));
      });

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
