import 'package:flutter/foundation.dart';

class Course with ChangeNotifier {
  final String id;
  final String name;
  final String image;
  final String description;
  final double price;
  final String language;

  Course(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.image,
      required this.language});
}
