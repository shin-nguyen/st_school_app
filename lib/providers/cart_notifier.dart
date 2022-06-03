import 'dart:ffi';

import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/foundation.dart';
import 'package:st_school_app/models/course.dart';

class CartNotifier with ChangeNotifier {
  CartNotifier() {
    _items.putIfAbsent(
      '11',
      () => const Course(
          id: 11,
          name: 'The Complete 2020 Fullstack Web Developer Course',
          description:
              'HTML is the standard markup language for Web pages. With HTML you can create your own Website.',
          lecturer: 'Kari Noman',
          language: 'English',
          price: 123,
          image:
              "https://res.cloudinary.com/qscloud/image/upload/v1635049180/st-school/images/html.png.png",
          subTotal: 1,
          videoTotal: 20,
          topic: "ADs",
          progress: 12,
          subPrice: 2,
          video: 123,
          averageRate: 1,
          createdTime: "123",
          isFor: "Beginner"),
    );
    _items.putIfAbsent(
      '10',
      () => const Course(
          id: 10,
          name:
              'Python Django - The Practical GuideLearn how to build web applications and websites with Python and the Django framework',
          description:
              'HTML is the standard markup language for Web pages. With HTML you can create your own Website.',
          lecturer: 'Kari Noman',
          language: 'English',
          price: 10,
          image:
              "https://res.cloudinary.com/qscloud/image/upload/v1635049180/st-school/images/html.png.png",
          subTotal: 1,
          videoTotal: 20,
          topic: "ADs",
          progress: 12,
          subPrice: 4,
          video: 123,
          averageRate: 1,
          createdTime: "123",
          isFor: "Beginner"),
    );
  }

  List<S2Choice<String>> options = [
    S2Choice<String>(value: 'gpay', title: 'Gooogle Pay'),
    S2Choice<String>(value: 'paypal', title: 'Pay Pal'),
  ];

  Map<String, Course> _items = {};
  String choosePay = 'gpay';

  Map<String, Course> get items {
    return {..._items};
  }

  List<Course> findById(String type) {
    Course course = Course.empty();
    _items.forEach((key, value) {
      if (key == type) {
        course = value;
      }
    });
    List<Course> courses = [course];
    return courses;
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      if (cartItem.subPrice != 0) {
        total += cartItem.subPrice;
      } else {
        total += cartItem.price;
      }
    });
    return total;
  }

  void addItem(Course course) {
    if (_items.containsKey(course.id)) {
      // change quantity...
      // _items.update(
      //   productId,
      //   (existingCartItem) => CartItem(
      //     id: existingCartItem.id,
      //     title: existingCartItem.title,
      //     price: existingCartItem.price,
      //     quantity: existingCartItem.quantity + 1,
      //   ),
      // );
    } else {
      _items.putIfAbsent(
        course.id.toString(),
        () => course,
      );
    }
    notifyListeners();
  }

  void removeItem(String coureId) {
    _items.remove(coureId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
