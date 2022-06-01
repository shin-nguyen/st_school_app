import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:st_school_app/constants/system_constants.dart';

class CunstomPlaceHolder extends StatefulWidget {
  const CunstomPlaceHolder({
    Key? key,
    required this.title,
    this.isSwitch = false,
    this.onTap,
  }) : super(key: key);
  final String title;
  final bool isSwitch;
  final Function()? onTap;

  @override
  _CunstomPlaceHolderState createState() => _CunstomPlaceHolderState();
}

class _CunstomPlaceHolderState extends State<CunstomPlaceHolder> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.width * .1,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 15.0,
                color: grey,
              ),
            ),
            (widget.isSwitch)
                ? CupertinoSwitch(
                    value: switchValue,
                    activeColor: primary,
                    onChanged: (bool newValue) {
                      setState(() {
                        switchValue = newValue;
                      });
                    },
                  )
                : SvgPicture.asset(assetImg + 'arrow_up_icon.svg'),
          ],
        ),
      ),
    );
  }
}
