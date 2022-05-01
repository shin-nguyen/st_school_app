import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  final String name;
  final Icon iconName;

  Category(this.name, this.iconName);
}

List<Category> categoriesList = [
  Category('Development', Icon(Icons.code_outlined, color: Colors.white)),
  Category('Business', Icon(Icons.insert_chart_outlined, color: Colors.white)),
  Category('IT & Software', Icon(Icons.computer_outlined, color: Colors.white)),
  Category('Personal Development', Icon(Icons.favorite, color: Colors.white)),
  Category('Photography & Video',
      Icon(Icons.photo_camera_outlined, color: Colors.white)),
  Category('Music', Icon(Icons.music_note_outlined, color: Colors.white)),
  Category('Design', Icon(Icons.design_services_outlined, color: Colors.white)),
  Category('Finance & Accountings',
      Icon(Icons.account_balance_wallet_outlined, color: Colors.white)),
  Category('Office Productivity',
      Icon(Icons.event_note_outlined, color: Colors.white)),
  Category('Marketing', Icon(Icons.star, color: Colors.white)),
  Category('Lifestyle', Icon(FontAwesomeIcons.dog, color: Colors.white)),
  Category('Health & Fitness',
      Icon(FontAwesomeIcons.heartbeat, color: Colors.white)),
  Category('Teaching & Academics',
      Icon(Icons.book_online_outlined, color: Colors.white)),
];
