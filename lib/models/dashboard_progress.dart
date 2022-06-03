import 'package:flutter/cupertino.dart';
import 'package:st_school_app/constants/system_constants.dart';

class DashboardProgress {
  String day;
  double count;
  List<Color> color;
  DashboardProgress({
    required this.day,
    required this.count,
    required this.color,
  });

  factory DashboardProgress.empty() {
    return DashboardProgress(
      day: "Sun",
      count: 0,
      color: [secondary, primary],
    );
  }
}

// const List weekly = [
//   {
//     "day": "Sun",
//     "count": 0.1,
//     "color": [secondary, primary]
//   },
//   {
//     "day": "Mon",
//     "count": 0.08,
//     "color": [fourthColor, thirdColor]
//   },
//   {
//     "day": "Tue",
//     "count": 0.12,
//     "color": [secondary, primary]
//   },
//   {
//     "day": "Wed",
//     "count": 0.075,
//     "color": [fourthColor, thirdColor]
//   },
//   {
//     "day": "Thu",
//     "count": 0.09,
//     "color": [secondary, primary]
//   },
//   {
//     "day": "Fri",
//     "count": 0.05,
//     "color": [fourthColor, thirdColor]
//   },
//   {
//     "day": "Sat",
//     "count": 0.097,
//     "color": [secondary, primary]
//   }
// ];
