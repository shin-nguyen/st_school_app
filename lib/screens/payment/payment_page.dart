import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/providers/orders_notifier.dart';
import 'package:st_school_app/screens/checkout/cart_page.dart';
import 'package:st_school_app/screens/home/home-page/home_page.dart';
import 'package:st_school_app/utils/app_color.dart';
import 'package:st_school_app/widgets/buttons.dart';
import 'package:st_school_app/widgets/large_buttons.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  static const routeName = '/payments';
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrdersNotifier>(context);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
        height: h,
        width: w,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/paymentbackground.png"))),
        child: Column(children: [
          Container(
            width: double.maxFinite,
            height: h * 0.14,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage("assets/images/success.png"))),
          ),
          const Text(
            "Success",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColor.mainColor),
          ),
          Text(
            "Payment is completed for ${order.orders.courses.length} bills",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColor.idColor),
          ),
          SizedBox(
            height: h * 0.045,
          ),
          Container(
            height: w * 0.5,
            width: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(width: 2, color: Colors.grey.withOpacity(0.5))),
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.builder(
                  itemCount: order.orders.courses.length,
                  itemBuilder: (_, index) {
                    return Container(
                      height: w * 0.25,
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
                                      order.orders.courses[index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: miniSpacer),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order.orders.courses[index].name,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Intructor: ${order.orders.courses[index].lecturer}',
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
                                '\$ ${order.orders.courses[index].price}',
                                style: const TextStyle(
                                  color: textBlack,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              // SizedBox(
                              //   width: w * .1,
                              // )
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: h * 0.05,
          ),
          Column(
            children: [
              const Text(
                "Total Amount",
                style: TextStyle(fontSize: 20, color: idColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "\$ ${order.totalOrder}",
                style: const TextStyle(fontSize: 20, color: idColor),
              )
            ],
          ),
          SizedBox(
            height: h * 0.12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButtons(icon: Icons.share_sharp, onTap: () {}, text: "share"),
              SizedBox(
                width: w * 0.25,
              ),
              AppButtons(
                  icon: Icons.print_outlined, onTap: () {}, text: "print")
            ],
          ),
          SizedBox(
            height: h * 0.02,
          ),
          AppLargeButton(
            text: "Done",
            backgroundColor: Colors.white,
            textColor: AppColor.mainColor,
            onTap: () {
              Navigator.pushNamed(
                context,
                CartPage.routeName,
              );
            },
          )
        ]),
      ),
    );
  }
}
