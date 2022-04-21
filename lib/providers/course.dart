import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Course with ChangeNotifier {
  final String id;
  final String name;
  final String image;
  final String description;
  final double price;
  final String language;

  Course(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.price,
      @required this.image,
      @required this.language});

  // Future<void> toggleFavoriteStatus(String token, String userId) async {
  //   final oldStatus = isFavorite;
  //   isFavorite = !isFavorite;
  //   notifyListeners();
  //   final url = Uri.https('flutter-update.firebaseio.com',
  //       '/userFavorites/$userId/$id.json?auth=$token');
  //   try {
  //     final response = await http.put(
  //       url,
  //       body: json.encode(
  //         isFavorite,
  //       ),
  //     );
  //     if (response.statusCode >= 400) {
  //       _setFavValue(oldStatus);
  //     }
  //   } catch (error) {
  //     _setFavValue(oldStatus);
  //   }
  // }
}
