import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:st_school_app/constants/system_constants.dart';

class CustomSearchField extends StatefulWidget {
  const CustomSearchField({
    Key? key,
    required this.hintField,
    this.backgroundColor,
  }) : super(key: key);

  final String hintField;
  final Color? backgroundColor;

  @override
  _CustomSearchFieldState createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Container(
      width: w,
      height: spacer,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40.0,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              assetImg + 'search_icon.svg',
              color: secondary.withOpacity(0.5),
              height: 15.0,
            ),
          ),
          Flexible(
              child: Container(
            width: w,
            height: 38,
            alignment: Alignment.topCenter,
            child: TextField(
              style: const TextStyle(fontSize: 15),
              cursorColor: textBlack,
              decoration: InputDecoration(
                  hintText: widget.hintField,
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: secondary.withOpacity(0.5),
                  ),
                  border: InputBorder.none),
            ),
          )),
          const SizedBox(
            width: 10.0,
          ),
          Container(
            height: 40.0,
            width: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: primary.withOpacity(0.7),
                borderRadius: BorderRadius.circular(7.0),
                boxShadow: [
                  BoxShadow(
                    color: primary.withOpacity(0.5),
                    spreadRadius: 0.0,
                    blurRadius: 6.0,
                    offset: const Offset(0, 2),
                  )
                ]),
            child: SvgPicture.asset(
              assetImg + 'filter_icon.svg',
              color: textWhite,
              height: 13.0,
            ),
          )
        ],
      ),
    );
  }
}
