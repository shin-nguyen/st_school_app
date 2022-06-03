import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<Map<String, String>> items;
  final String value;
  final onChanged;

  const CustomDropdownButton(
      {Key? key,
      required this.items,
      required this.value,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      items: items
          .map(
            (Map i) => DropdownMenuItem(
              value: i["value"].toString(),
              child: Text(i["name"]),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
