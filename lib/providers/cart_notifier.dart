import 'package:flutter/foundation.dart';
import 'package:st_school_app/models/cart_item.dart';

class CartNotifier with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
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

  void addItem(
    int courseId,
    double price,
    String title,
  ) {
    if (_items.containsKey(courseId)) {
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
        courseId.toString(),
        () => CartItem(
          id: courseId,
          title: title,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
