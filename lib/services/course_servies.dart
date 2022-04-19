import 'dart:convert';
import 'dart:html';

import 'package:st_school_app/models/course.dart';

import 'package:http/http.dart' as http;

Future<List<Course>> fetchCourses() async {
  final response = await http.get(
      Uri.parse('https://http://localhost:8080/api/v1/course/list'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '<Your token>'
      });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var responseBody = jsonDecode(response.body);
    List<Course> listCourse = [];
    responseBody.forEach((e) {
      Course course = Course.fromJson(e);
      listCourse.add(course);
    });
    return listCourse;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load course');
  }
}
