import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/providers/cart_notifier.dart';
import 'package:st_school_app/screens/checkout/components/order_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  static const routeName = '/cart-page';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartNotifier>(context);
    return Scaffold(
        backgroundColor: background,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Cart",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: textBlack,
            ),
          ),
        ),
        body: cart.itemCount == 0
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Add courses",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                      color: textBlack,
                    ),
                  ),
                  const SizedBox(
                    height: miniSpacer,
                  ),
                  RichText(
                    text: TextSpan(
                      children: const [
                        TextSpan(
                          text: 'Your cart is empty',
                        ),
                      ],
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ))
            : OrderList(
                cart: cart,
              ));
  }
}
