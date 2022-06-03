import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/providers/cart_notifier.dart';
import 'package:st_school_app/providers/orders_notifier.dart';
import 'package:st_school_app/screens/checkout/components/cart_item_page.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:st_school_app/screens/checkout/components/paypal_payment.dart';
import 'package:st_school_app/screens/payment/payment_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  static const routeName = '/cart-page';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Razorpay razorpay = Razorpay();

  // @override
  // void initState() {
  //   super.initState();

  //   razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
  //   razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
  //   razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  // }

  // void handlerPaymentSuccess() {
  //   print("Pament success");
  //   Toast.show("Pament success", context, border: Border.all(width: 1));
  // }

  // void handlerErrorFailure() {
  //   print("Pament error");
  //   Toast.show("Pament error", context, border: Border.all(width: 1));
  // }

  // void handlerExternalWallet() {
  //   print("External Wallet");
  //   Toast.show("External Wallet", context, border: Border.all(width: 1));
  // }

  // void openCheckout() {
  //   var options = {
  //     "key": "rzp_test_lZ2Lyxj8jBeTWY",
  //     "amount": 1,
  //     "name": "Sample App",
  //     "description": "Payment for the some random product",
  //     "prefill": {
  //       "contact": "84918948074",
  //       "email": "thongchuthanh2000@gmail.com"
  //     },
  //     "external": {
  //       "wallets": ["paytm"]
  //     }
  //   };

  //   try {
  //     razorpay.open(options);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
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
                      padding: const EdgeInsets.only(top: 20),
                      itemCount: cart.items.length,
                      itemBuilder: (ctx, i) => CartItemPage(
                          id: cart.items.values.toList()[i].id.toString(),
                          price: cart.items.values.toList()[i].price.toDouble(),
                          description:
                              cart.items.values.toList()[i].description,
                          image: cart.items.values.toList()[i].image,
                          lecturer: cart.items.values.toList()[i].lecturer,
                          subPrice:
                              cart.items.values.toList()[i].subPrice.toDouble(),
                          choosePay: cart.choosePay),
                    ),
                  ),
                  SmartSelect<String>.single(
                    title: "CHOOSE PAYMENT",
                    selectedValue: cart.choosePay,
                    modalStyle: const S2ModalStyle(
                        backgroundColor: Colors.white,
                        clipBehavior: Clip.none,
                        elevation: 0.0),
                    modalHeaderStyle: const S2ModalHeaderStyle(
                      backgroundColor: background,
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: textBlack,
                      ),
                      iconTheme: IconThemeData(
                        color: Colors.black, //change your color here
                      ),
                    ),
                    choiceItems: cart.options,
                    onChange: (state) =>
                        setState(() => cart.choosePay = state.value!),
                  ),
                  Card(
                    margin: const EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Total  ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Chip(
                            label: Text(
                              '\$${cart.totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: textBlack,
                              ),
                            ),
                            backgroundColor: primary,
                          ),
                          (cart.choosePay == 'gpay')
                              ? GooglePayButton(
                                  paymentConfigurationAsset: 'gpay.json',
                                  paymentItems: [
                                    PaymentItem(
                                      label: 'Total',
                                      amount: cart.totalAmount
                                          .toStringAsFixed(2)
                                          .toString(),
                                      status: PaymentItemStatus.final_price,
                                    )
                                  ],
                                  width: w * 0.4,
                                  height: 40,
                                  style: GooglePayButtonStyle.black,
                                  type: GooglePayButtonType.pay,
                                  onPaymentResult: (data) async {
                                    debugPrint(data.toString());
                                    await Provider.of<OrdersNotifier>(context,
                                            listen: false)
                                        .addOrder(
                                      cart.items.values.toList(),
                                    );
                                    Navigator.pushNamed(
                                      context,
                                      PaymentPage.routeName,
                                      // arguments: courses[index].id,
                                    );
                                    cart.clear();
                                  },
                                  loadingIndicator: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : SizedBox(
                                  width: w * 0.4,
                                  height: 40,
                                  child: TextButton(
                                    onPressed: () {
                                      // lets assume that product price is 5.99 usd
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PaypalPayment(
                                              amount: 0.99,
                                              currency: 'USD',
                                            ),
                                          ));
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) => Colors.blue),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Image(
                                          image: AssetImage(
                                              'assets/images/paypal.png'),
                                          height: 40,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Pay with Paypal',
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
    );
  }
}
