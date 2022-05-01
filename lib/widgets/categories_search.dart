import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
import 'package:st_school_app/models/category_model.dart';

class Categories extends StatelessWidget {
  final Widget topWidget;

  Categories(this.topWidget);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {}, icon: Icon(FontAwesomeIcons.shoppingCart))
            ],
            backgroundColor: Colors.black,
            title: Text('Categories',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topWidget,
              ListView.builder(
                  itemCount: categoriesList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      radius: 0.4,
                      // onTap: () {
                      //   Get.to(CategoryDetail(),
                      //       arguments: categoriesList[i].name);
                      // },
                      child: Container(
                        child: ListTile(
                            leading: categoriesList[i].iconName,
                            title: Text(categoriesList[i].name,
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 16))),
                      ),
                    );
                  })
            ],
          ),
        ));
  }
}
