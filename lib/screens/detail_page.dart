import 'package:flutter/material.dart';
import 'package:st_school_app/widgets/appbar.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      const CustomeAppBar(),
      const SizedBox(
        height: 20,
      ),
      Text("Detail Page")
    ])));
  }
}
