import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  final String title;
  final String icon;

  Category(this.title, this.icon);
}

List<Category> categoryJson = [
  Category('Code', 'assets/images/code_icon.svg'),
  Category('Finance & Accounting', 'assets/images/bag_icon.svg'),
  Category('Design', 'assets/images/brush_icon.svg'),
  Category('Development', 'assets/images/bag_icon.svg'),
  Category('Business', 'assets/images/bag_icon.svg'),
  Category('IT & Software', 'assets/images/bag_icon.svg'),
];

List<Category> allCategories = [
  Category('Code', 'assets/images/code_icon.svg'),
  Category('Finance & Accounting', 'assets/images/bag_icon.svg'),
  Category('Design', 'assets/images/brush_icon.svg'),
  Category('Development', 'assets/images/bag_icon.svg'),
  Category('Business', 'assets/images/bag_icon.svg'),
  Category('IT & Software', 'assets/images/bag_icon.svg'),
  Category('Photography & Video', 'assets/images/bag_icon.svg'),
  Category('Marketing', 'assets/images/bag_icon.svg'),
  Category('Lifestyle', 'assets/images/bag_icon.svg'),
  Category('Office Productivity', 'assets/images/bag_icon.svg'),
  Category('Music', 'assets/images/bag_icon.svg'),
  Category('Personal Development', 'assets/images/bag_icon.svg'),
];
