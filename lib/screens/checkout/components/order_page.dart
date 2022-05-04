import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:st_school_app/models/course.dart';
import 'package:st_school_app/screens/home/home_page.dart';
import 'package:st_school_app/screens/home/profile/profile_page.dart';
import 'package:st_school_app/screens/payment/payment_page.dart';
import 'package:st_school_app/utils/app_color.dart';
import 'package:st_school_app/widgets/text_size.dart';
import 'package:pay/pay.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 320,
        left: 0,
        right: 0,
        bottom: 0,
        child: ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: courses.length,
            itemBuilder: (context, index) => OrderCard(
                  course: courses[index],
                )));
  }
}

class OrderCard extends StatelessWidget {
  OrderCard({
    Key? key,
    required this.course,
  }) : super(key: key);
  final Course course;
  final _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        height: 130,
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Color(0xFFd8),
                  offset: Offset(1, 1),
                  blurRadius: 20.0,
                  spreadRadius: 10)
            ]),
        child: Container(
            margin: const EdgeInsets.only(top: 10, left: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 3, color: Colors.grey),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/images/kai.jpg'))),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "KenGen Power",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "ID: 846594",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedText(
                        text: "Auto pay on 24th May 18", color: Colors.green),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 35,
                          padding: EdgeInsets.only(bottom: 10, top: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColor.selectBackground),
                          child: Center(
                            child: IconButton(
                                onPressed: () => {
                                      Navigator.pushNamed(
                                          context, PaymentPage.routeName)
                                    },
                                icon: const Icon(Icons.check_outlined),
                                color: AppColor.selectColor),
                          ),
                        ),
                        // GooglePayButton(
                        //   width: 300,
                        //   paymentConfigurationAsset: 'assets/data/gpay.json',
                        //   paymentItems: _paymentItems,
                        //   style: GooglePayButtonStyle.black,
                        //   type: GooglePayButtonType.pay,
                        //   margin: const EdgeInsets.only(top: 15.0),
                        //   onPaymentResult: onGooglePayResult,
                        //   loadingIndicator: const Center(
                        //     child: CircularProgressIndicator(),
                        //   ),
                        // ),

                        Expanded(child: Container()),
                        Text(
                          "\$1248.00",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColor.mainColor),
                        ),
                        Text(
                          "Due in 3 days",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColor.idColor),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 5,
                      height: 35,
                      decoration: BoxDecoration(
                          color: AppColor.halfOval,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          )),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
