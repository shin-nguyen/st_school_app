import 'package:flutter/material.dart';

class BackButton extends StatefulWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  State<BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<BackButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Positioned(
          left: 15,
          top: 15,
          child: Row(
            children: [
              IconButton(
                  onPressed: () => {Navigator.pop(context)},
                  icon: Icon(Icons.arrow_back),
                  color: Color.fromARGB(255, 10, 10, 10))
            ],
          )),
    );
  }
}
