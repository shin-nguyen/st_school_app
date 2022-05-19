import 'package:st_school_app/models/cart_item.dart';

class OrderItem {
  final String id;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.products,
    required this.dateTime,
  });
}
