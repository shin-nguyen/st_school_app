import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/license.dart';
import 'package:st_school_app/widgets/licenses_widget.dart';

class LicensesCustomPage extends StatelessWidget {
  const LicensesCustomPage({
    Key? key,
    required this.file,
    required this.title,
  }) : super(key: key);
  final String file;
  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: background,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          titleSpacing: 0,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: textBlack,
            ),
          ),
        ),
        body: FutureBuilder<List<License>>(
          future: loadLicenses(context),
          builder: (context, snapshot) {
            final licenses = snapshot.data;

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return const Center(child: Text('Some error occurred!'));
                } else {
                  return LicensesWidget(licenses: licenses!);
                }
            }
          },
        ),
      );

  Future<List<License>> loadLicenses(BuildContext context) async {
    final bundle = DefaultAssetBundle.of(context);
    final licenses = await bundle.loadString('assets/data/$file.json');

    return json
        .decode(licenses)
        .map<License>((license) => License.fromJson(license))
        .toList();
  }
}
