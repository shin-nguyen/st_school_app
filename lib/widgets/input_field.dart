import 'package:flutter/material.dart';
import 'package:st_school_app/constants/system_constants.dart';

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
      this.isPassword = true,
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
                    side: const BorderSide(color: Colors.red, width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  )
                : RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
                onChanged: (value) => widget.onValueChanged!(value),
                style: const TextStyle(
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
                        ? const Icon(
                            Icons.close,
                            color: Colors.red,
                          )
                        : isChecked
                            ? const Icon(Icons.done)
                            : null,
                    hintStyle: const TextStyle(
                        color: background,
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
