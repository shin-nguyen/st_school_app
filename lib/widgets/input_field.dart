import 'package:flutter/material.dart';

class OpenFlutterInputField extends StatefulWidget {
  final TextEditingController controller;
  String? hint;
  FormFieldValidator? validator;
  final TextInputType keyboard;
  FocusNode? focusNode;
  VoidCallback? onFinished;
  final bool isPassword;
  final double horizontalPadding;
  Function? onValueChanged;
  String? error;

  OpenFlutterInputField(
      {Key? key,
      required this.controller,
      this.hint,
      this.validator,
      this.keyboard = TextInputType.text,
      this.focusNode,
      this.onFinished,
      this.isPassword = false,
      this.horizontalPadding = 16.0,
      this.onValueChanged,
      this.error})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return OpenFlutterInputFieldState();
  }
}

class OpenFlutterInputFieldState extends State<OpenFlutterInputField> {
  String? error;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    error = widget.error;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 3,
            shape: error != null
                ? RoundedRectangleBorder(
                    side: BorderSide(color: Colors.red, width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  )
                : RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: TextField(
                onChanged: (value) => widget.onValueChanged!(value),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
                controller: widget.controller,
                focusNode: widget.focusNode,
                keyboardType: widget.keyboard,
                obscureText: widget.isPassword,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: widget.hint,
                    hintText: widget.hint,
                    suffixIcon: error != null
                        ? Icon(
                            Icons.close,
                            color: Colors.red,
                          )
                        : isChecked
                            ? Icon(Icons.done)
                            : null,
                    hintStyle: TextStyle(
                        color: Color(0xFF9B9B9B),
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
              ),
            ),
          ),
          error == null
              ? Container()
              : Text(
                  error!,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                )
        ],
      ),
    );
  }

  String validate() {
    setState(() {
      error = widget.validator!(widget.controller.text);
    });
    return error!;
  }
}
