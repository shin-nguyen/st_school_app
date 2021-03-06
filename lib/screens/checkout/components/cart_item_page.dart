import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/providers/cart_notifier.dart';
import 'package:st_school_app/providers/orders_notifier.dart';
import 'package:st_school_app/screens/checkout/components/paypal_payment.dart';
import 'package:st_school_app/screens/payment/payment_page.dart';

class CartItemPage extends StatelessWidget {
  const CartItemPage(
      {Key? key,
      required this.id,
      required this.price,
      required this.description,
      required this.image,
      required this.lecturer,
      required this.choosePay,
      required this.subPrice})
      : super(key: key);

  final String id;
  final double price;
  final double subPrice;
  final String description;
  final String image;
  final String lecturer;
  final String choosePay;

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartNotifier>(context);
    var w = MediaQuery.of(context).size.width;

    return Dismissible(
        key: ValueKey(id),
        background: Container(
          color: Theme.of(context).errorColor,
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text(
                'Do you want to remove the item from the cart?',
              ),
              actions: [
                FlatButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                ),
                FlatButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                ),
              ],
            ),
          );
        },
        onDismissed: (direction) {
          Provider.of<CartNotifier>(context, listen: false).removeItem(id);
        },
        child: Container(
          height: w * 0.4,
          width: w - 10,
          padding: const EdgeInsets.only(top: 12, left: 12),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                    color: Color(0x0000ffd8),
                    offset: Offset(1, 1),
                    blurRadius: 20.0,
                    spreadRadius: 10)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: w * .14,
                child: Row(
                  children: [
                    SizedBox(
                      height: w * .18,
                      width: w * .13,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: miniSpacer),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: secondary,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: miniSpacer),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Intructor: ' + lecturer,
                                style: const TextStyle(
                                  fontSize: 11.0,
                                  color: grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: w * .16,
              //     ),
              //     Text(
              //       '\$ $price',
              //       style: const TextStyle(
              //         color: textBlack,
              //         fontSize: 15.0,
              //         fontWeight: FontWeight.w700,
              //       ),
              //     ),
              //     SizedBox(
              //       width: w * .1,
              //     )
              //   ],
              // ),
              Row(
                children: [
                  SizedBox(
                    width: w * .16,
                  ),
                  Text(
                    '\$' +
                        (subPrice != 0
                            ? subPrice.toString()
                            : price.toString()),
                    style: const TextStyle(
                        color: textBlack,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800),
                  ),
                  subPrice != 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '\$' + price.toString(),
                                  ),
                                ],
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey.shade500,
                                    fontSize: 14.0)),
                          ),
                        )
                      : Container(),
                ],
              ),
              const SizedBox(height: 10),
              (choosePay == 'gpay')
                  ? GooglePayButton(
                      paymentConfigurationAsset: 'gpay.json',
                      paymentItems: [
                        PaymentItem(
                          label: 'Total',
                          amount: price.toString(),
                          status: PaymentItemStatus.final_price,
                        )
                      ],
                      width: w * 0.9,
                      height: 40,
                      style: GooglePayButtonStyle.black,
                      type: GooglePayButtonType.pay,
                      onPaymentResult: (data) async {
                        debugPrint(data.toString());
                        await Provider.of<OrdersNotifier>(context,
                                listen: false)
                            .addOrder(
                          cart.findById(id),
                        );
                        Navigator.pushNamed(
                          context,
                          PaymentPage.routeName,
                          // arguments: courses[index].id,
                        );
                        cart.removeItem(id);
                      },
                      loadingIndicator: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox(
                      width: w * 0.9,
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          // lets assume that product price is 5.99 usd
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaypalPayment(
                                  amount: price,
                                  currency: 'USD',
                                ),
                              ));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.blue),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Image(
                              image: AssetImage('assets/images/paypal.png'),
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
        ));
  }
}
