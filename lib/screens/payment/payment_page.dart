import 'package:flutter/material.dart';
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
            "Payment is completed",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColor.idColor),
          ),
          SizedBox(
            height: h * 0.045,
          ),
          Container(
            height: 95,
            width: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(width: 2, color: Colors.grey.withOpacity(0.5))),
            child: Container(
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 15, left: 20, bottom: 10),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.green),
                      child: Icon(
                        Icons.done,
                        size: 30,
                        color: Colors.white,
                      ),
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
                              fontWeight: FontWeight.bold,
                              color: AppColor.mainColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("KenGen Power",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColor.idColor))
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text(
                          "",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColor.mainColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "\$100",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColor.mainColor),
                        ),
                      ],
                    ),
                  ],
                ),
                // Divider(
                //   thickness: 2,
                //   color: Colors.grey.withOpacity(0.5),
                // )
              ]),
            ),
          ),
          SizedBox(
            height: h * 0.1,
          ),
          Column(
            children: [
              Text(
                "Total Amount",
                style: TextStyle(fontSize: 20, color: AppColor.idColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "\$2840.00",
                style: TextStyle(fontSize: 20, color: AppColor.idColor),
              )
            ],
          ),
          SizedBox(
            height: h * 0.14,
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
          const AppLargeButton(
            text: "Done",
            backgroundColor: Colors.white,
            textColor: AppColor.mainColor,
          )
        ]),
      ),
    );
  }
}
