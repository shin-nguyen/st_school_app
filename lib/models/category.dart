import 'package:flutter/material.dart';

class Category {
  final String title;
  final String icon;
  Color color;
  int courses = 0;
  Category(this.title, this.icon,
      [this.color = const Color(0xFF71b8ff), this.courses = 0]);
}

final List<Category> categoryJson = [
  Category('Software', 'assets/images/code_icon.svg'),
  Category('Business', 'assets/images/bag_icon.svg'),
  Category('Finance & Accounting', 'assets/images/bag_icon.svg'),
  Category('Design', 'assets/images/brush_icon.svg'),
  Category('Development', 'assets/images/bag_icon.svg'),
  Category('IT & Software', 'assets/images/bag_icon.svg'),
];

final List<Category> categoryJsonTwo = [
  Category('Development', 'assets/images/bag_icon.svg'),
  Category('Marketing', 'assets/images/bag_icon.svg'),
  Category('Lifestyle', 'assets/images/brush_icon.svg'),
  Category('Office Productivity', 'assets/images/bag_icon.svg'),
  Category('Music', 'assets/images/bag_icon.svg'),
  Category('Personal Development', 'assets/images/bag_icon.svg'),
];

final List<Category> homePageCategoryJson = [
  Category('Code', 'assets/images/code_icon.svg'),
  Category('Design', 'assets/images/brush_icon.svg'),
  Category('Business', 'assets/images/bag_icon.svg'),
];

final List<Category> allCategories = [
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
