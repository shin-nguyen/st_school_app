import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/providers/cart_notifier.dart';
import 'package:st_school_app/screens/checkout/components/cart_item_page.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:st_school_app/widgets/toast.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  static const routeName = '/cart-page';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Razorpay razorpay = Razorpay();

  @override
  void initState() {
    super.initState();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  void handlerPaymentSuccess() {
    print("Pament success");
    Toast.show("Pament success", context, border: Border.all(width: 1));
  }

  void handlerErrorFailure() {
    print("Pament error");
    Toast.show("Pament error", context, border: Border.all(width: 1));
  }

  void handlerExternalWallet() {
    print("External Wallet");
    Toast.show("External Wallet", context, border: Border.all(width: 1));
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_lZ2Lyxj8jBeTWY",
      "amount": 1,
      "name": "Sample App",
      "description": "Payment for the some random product",
      "prefill": {
        "contact": "84918948074",
        "email": "thongchuthanh2000@gmail.com"
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartNotifier>(context);
    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        titleSpacing: 0,
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
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 2 * spacer),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: cart.itemCount.toString() + " item",
                        ),
                      ],
                      style: const TextStyle(
                          color: textBlack,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 20),
                      itemCount: cart.items.length,
                      itemBuilder: (ctx, i) => CartItemPage(
                        id: cart.items.values.toList()[i].id.toString(),
                        price: cart.items.values.toList()[i].price.toDouble(),
                        description: cart.items.values.toList()[i].description,
                        image: cart.items.values.toList()[i].image,
                        lecturer: cart.items.values.toList()[i].lecturer,
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Total',
                            style: TextStyle(fontSize: 20),
                          ),
                          const Spacer(),
                          Chip(
                            label: Text(
                              '\$${cart.totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: textBlack,
                              ),
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          FlatButton(
                            child: const Text('ORDER NOW'),
                            onPressed: (cart.totalAmount <= 0)
                                ? null
                                : () {
                                    openCheckout();
                                    // setState(() {
                                    //   _isLoading = true;
                                    // });
                                    // await Provider.of<Orders>(context, listen: false).addOrder(
                                    //   widget.cart.items.values.toList(),
                                    //   widget.cart.totalAmount,
                                    // );
                                    // setState(() {
                                    //   _isLoading = false;
                                    // });
                                    // widget.cart.clear();
                                  },
                            textColor: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
    );
  }
}
