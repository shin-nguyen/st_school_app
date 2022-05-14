import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/course.dart';
import 'package:st_school_app/providers/cart_notifier.dart';
import 'package:st_school_app/screens/payment/payment_page.dart';
import 'package:st_school_app/utils/app_color.dart';
import 'package:st_school_app/widgets/text_size.dart';

class OrderList extends StatefulWidget {
  const OrderList({
    Key? key,
    required this.cart,
  }) : super(key: key);
  final CartNotifier cart;

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: spacer + spacer),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.cart.itemCount.toString() + " item",
                ),
              ],
              style: const TextStyle(
                  color: textBlack,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
//list categories
          Column(
            children: List.generate(widget.cart.items.length, (index) {
              var data = widget.cart.items[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: miniSpacer),
                child: GestureDetector(
                  onTap: () {},
                  child: OrderCard(
                    course: widget.cart.items.values.toList()[index],
                  ),
                ),
              );
            }),
          )
        ]));
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.course,
  }) : super(key: key);
  final Course course;
  // final _paymentItems = [
  //   PaymentItem(
  //     label: 'Totalllll',
  //     amount: '99.99',
  //     status: PaymentItemStatus.final_price,
  //   )
  // ];
  // void onGooglePayResult(paymentResult) {
  //   debugPrint(paymentResult.toString());
  // }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Container(
      height: w * 0.3,
      width: w - 20,
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
                      course.image,
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
                        course.description,
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
                            'Intructor: ' + course.lecturer,
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
          Row(
            children: [
              SizedBox(
                width: w * .16,
              ),
              Text(
                '\$ ${course.price}',
                style: const TextStyle(
                  color: textBlack,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: w * .1,
              ),
              TextButton(
                onPressed: () {
                  Provider.of<CartNotifier>(context, listen: false)
                      .removeItem(course.id.toString());
                },
                child: const Text(
                  'Remove',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
