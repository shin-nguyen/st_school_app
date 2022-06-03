import 'dart:async';
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';
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
  String? _token;
  String? email;
  String? userRole;
  DateTime? _expiryDate;
  Timer? _authTimer;

  bool get isAuth {
    return _token != null && _token != "";
  }

  String? get getToken {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null &&
        _token != "") {
      return _token;
    }
    return null;
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

      _token = responseData['token'];
      email = responseData['email'];
      userRole = responseData['userRole'];

      _expiryDate = Jwt.getExpiryDate(_token!);
      _autoLogout();
      notifyListeners();
      // Create storage
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      // Write value
      await prefs.setString('token', _token!);
      await prefs.setString('expiryDate', _expiryDate!.toIso8601String());
    } else if (response.statusCode == 403) {
      throw Exception(response.body);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
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
    _token = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('expiryDate')) {
      return false;
    }
    if (!prefs.containsKey('token')) {
      return false;
    }

    final expiryDate = DateTime.parse(prefs.getString('expiryDate')!);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = prefs.getString('token');
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }
}
