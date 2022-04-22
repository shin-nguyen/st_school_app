import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants/base_constants.dart' as Constants;
import '../models/http_exception.dart';

class User with ChangeNotifier {
  int id;
  String firstName;
  String lastName;
  String phone;
  String address;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.address,
  });

  User? get user {
    return User(
        id: id,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        address: address);
  }

  Future<void> getInfoByToken(String token) async {
    final url = Uri.parse(Constants.BASE_URL + '/api/v1/users/info');

    try {
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": token
      });
      final responseData = json.decode(response.body);
      if (responseData['id'] == null) {
        throw HttpException(responseData);
      }

      id = responseData['id'];
      firstName = responseData['firstName'];
      lastName = responseData['lastName'];
      phone = responseData['phone'];
      address = responseData['address'];

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(String token, User newUser) async {
    final url = Uri.parse(Constants.BASE_URL + '/api/v1/users/edit');

    await http.put(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": token
        },
        body: json.encode({
          'firstName': newUser.firstName,
          'lastName': newUser.lastName,
          'phone': newUser.phone,
          'address': newUser.address
        }));

    notifyListeners();
  }
}
