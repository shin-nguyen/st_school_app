import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel(this.email, this.password);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
    };

    return map;
  }
}

class AuthNotifier with ChangeNotifier {
  String? token;
  String? email;
  String? userRole;

  bool get isAuth {
    return token != "";
  }

  Future<void> login(LoginRequestModel requestModel) async {
    String url = baseUrl + '/api/v1/auth/login';

    final response = await http
        .post(Uri.parse(url), body: json.encode(requestModel), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      token = responseData['token'];
      email = responseData['email'];
      userRole = responseData['userRole'];

      // Create storage
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      // Write value
      await prefs.setString('token', token!);

      notifyListeners();
    } else if (response.statusCode == 403) {
      throw Exception(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<void> signup({
    required String email,
    required String password,
    required String password2,
    required String firstName,
    required String lastName,
  }) async {
    String url = baseUrl + '/api/v1/registration/mobile';

    final response = await http.post(Uri.parse(url),
        body: json.encode({
          "email": email,
          "firstName": firstName,
          "password": password,
          "password2": password2,
          "lastName": lastName,
        }),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        });

    if (response.statusCode == 200) {
    } else if (response.statusCode == 403) {
      throw Exception(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<void> logout() async {
    token = "";
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    notifyListeners();
  }
}
