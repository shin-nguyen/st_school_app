import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/license.dart';

class LicensesWidget extends StatelessWidget {
  final List<License> licenses;

  const LicensesWidget({
    Key? key,
    required this.licenses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
        padding: const EdgeInsets.only(top: spacer * 2),
        itemCount: licenses.length,
        itemBuilder: (context, index) {
          final license = licenses[index];
          return ListTile(
            title: Container(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: Html(
                data: license.title,
              ),
            ),
            subtitle: Html(
              data: license.text,
            ),
          );
        },
      );
}
