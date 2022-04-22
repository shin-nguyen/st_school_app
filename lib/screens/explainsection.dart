import 'package:flutter/material.dart';

class ExplainSection extends StatefulWidget {
  final String title;
  final String desc;

  const ExplainSection({Key? key, required this.title, required this.desc})
      : super(key: key);

  @override
  _ExplainSectionState createState() => _ExplainSectionState();
}

class _ExplainSectionState extends State<ExplainSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: 200,
            width: 400,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/best_on.png'),
                    fit: BoxFit.contain)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            widget.title,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 75),
          child:
              Text(widget.desc, style: TextStyle(color: Colors.grey.shade500)),
        ),
      ],
    );
  }
}
