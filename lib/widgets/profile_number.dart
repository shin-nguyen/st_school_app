import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  final int all;
  final int inProress;
  final int done;

  const NumbersWidget({
    Key? key,
    required this.all,
    required this.inProress,
    required this.done,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildButton(
          context,
          all.toString(),
          'All',
        ),
        buildDivider(),
        buildButton(
          context,
          inProress.toString(),
          'In Progress',
        ),
        buildDivider(),
        buildButton(
          context,
          done.toString(),
          'Done',
        ),
      ],
    );
  }

  Widget buildDivider() => const SizedBox(
        height: 24,
        child: VerticalDivider(
          thickness: 2,
        ),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 2),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
