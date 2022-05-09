import 'package:flutter/material.dart';

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
