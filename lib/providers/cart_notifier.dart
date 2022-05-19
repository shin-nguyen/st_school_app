import 'package:flutter/foundation.dart';
import 'package:st_school_app/models/course.dart';

class CartNotifier with ChangeNotifier {
  CartNotifier() {
    _items.putIfAbsent(
      '1231',
      () => Course(
          id: 1,
          name: 'HTML Course',
          description:
              'HTML is the standard markup language for Web pages. With HTML you can create your own Website.',
          lecturer: 'Kari Noman',
          language: 'English',
          price: 122,
          image:
              "https://res.cloudinary.com/qscloud/image/upload/v1635049180/st-school/images/html.png.png",
          subTotal: 1,
          videoTotal: 20,
          category: "ADs",
          progress: 12,
          subPrice: 123,
          video: 123),
    );
  }
  Map<String, Course> _items = {};

  Map<String, Course> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price;
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
