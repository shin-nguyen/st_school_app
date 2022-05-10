import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/user.dart';
import 'package:http/http.dart' as http;

class UserNotifier with ChangeNotifier {
  User user;

  UserNotifier(this.user);

  User get getUser {
    return user;
  }

  Future<void> getInfoByToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get("token").toString();

    final response =
        await http.get(Uri.parse(baseUrl + '/api/v1/users/info'), headers: {
      "Authorization": token,
      "Content-Type": "application/json",
      "Accept": "application/json"
    });

    if (response.statusCode == 200 || response.statusCode == 400) {
      final responseData = json.decode(response.body);
      user = User.fromJson(responseData);

      notifyListeners();
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
