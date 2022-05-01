import 'package:flutter/material.dart';

import '../constants/system_constants.dart';

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: const Icon(
              Icons.dashboard_rounded,
              color: kblue,
            )),
        IconButton(
            onPressed: () =>
                {Navigator.pushReplacementNamed(context, "/checkout")},
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ))
      ],
    );
  }
}
