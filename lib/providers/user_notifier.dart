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
      await prefs.setInt('idUser', user.id);
      notifyListeners();
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<void> updateInfo(User userUpdate, String? filepath) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get("token").toString();

    if (filepath != null) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(baseUrl + '/api/v1/users/edit-image-and-info'),
      );
      request.headers["Authorization"] = token;
      request.files.add(await http.MultipartFile.fromPath('avatar', filepath));
      request.fields.addAll({
        'firstName': userUpdate.firstName,
        'lastName': userUpdate.lastName,
        'phone': userUpdate.phone,
        'address': userUpdate.address,
        'about': userUpdate.about
      });

      var response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 400) {
        final responseData = await response.stream.bytesToString();
        user = User.fromJson(json.decode(responseData));

        notifyListeners();
      } else {
        throw Exception('Failed to load data!');
      }
    } else {
      final response = await http.put(Uri.parse(baseUrl + '/api/v1/users/edit'),
          headers: {
            "Authorization": token,
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: json.encode({
            'firstName': userUpdate.firstName,
            'lastName': userUpdate.lastName,
            'phone': userUpdate.phone,
            'address': userUpdate.address,
            'about': userUpdate.about
          }));

      if (response.statusCode == 200 || response.statusCode == 400) {
        final responseData = json.decode(response.body);
        user = User.fromJson(responseData);

        notifyListeners();
      } else {
        throw Exception('Failed to load data!');
      }
    }
  }
}
