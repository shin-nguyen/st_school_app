import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/providers/cart_notifier.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
import 'package:st_school_app/utils/app_color.dart';
import 'package:st_school_app/widgets/app_text.dart';
import 'package:st_school_app/widgets/large_buttons.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';

  int gottenStars = 4;
  @override
  Widget build(BuildContext context) {
    final courseId =
        ModalRoute.of(context)?.settings.arguments as int; // is the id!
    final cart = Provider.of<CartNotifier>(context, listen: false);

    final course = Provider.of<CoursesNotifier>(
      context,
      listen: false,
    ).findById(courseId);

    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              )),
        ],
      ),
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
                child: Container(
              width: double.maxFinite,
              height: 330,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(course.image),
                fit: BoxFit.cover,
              )),
            )),
            Positioned(
              top: 300,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: [
                    Row(
                      //       child: Text(course.description,
                      // overflow: TextOverflow.ellipsis,
                      // maxLines: 2,
                      // style: const TextStyle(
                      //   color: textBlack,
                      //   fontSize: 20.0,
                      //   fontWeight: FontWeight.bold,
                      // )),
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(course.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 248, 175, 71),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(height: smallSpacer),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                            text: "Lecturer: ${course.lecturer}",
                            size: 13,
                            color: const Color.fromARGB(255, 94, 85, 85)),
                      ],
                    ),
                    const SizedBox(height: miniSpacer),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.35,
                            ),
                            child: const Text(
                              '4.7',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        RatingBarIndicator(
                          rating: 3.5,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          unratedColor: Colors.grey,
                          itemCount: 5,
                          itemSize: 18.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(width: miniSpacer),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text('${course.subTotal} Student',
                              style: const TextStyle(
                                color: textBlack,
                                fontSize: 14.0,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        AppText(
                            text: "Description", size: 18, color: Colors.black),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: const TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.announcement_sharp,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                TextSpan(text: '  Last updated 5/2021'),
                              ],
                              style: TextStyle(
                                color: textBlack,
                                fontSize: 14.0,
                              ),
                            ),
                          )
                        ]),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const WidgetSpan(
                                child: Icon(
                                  Icons.language_outlined,
                                  size: 18,
                                  color: Colors.grey,
                                ),
                              ),
                              TextSpan(text: '  ${course.language}'),
                            ],
                            style: const TextStyle(
                              color: textBlack,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              course.description,
                              overflow: TextOverflow.clip,
                            ),
                          )
                        ]),
                    const SizedBox(height: miniSpacer),
                    Row(
                      children: [
                        Text(
                            '\$' +
                                (course.subPrice != 0
                                    ? course.subPrice.toString()
                                    : course.price.toString()),
                            style: const TextStyle(
                                color: textBlack,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        course.subPrice != 0
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: RichText(
                                  textAlign: TextAlign.end,
                                  text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '\$' + course.price.toString(),
                                        ),
                                      ],
                                      style: const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: textBlack,
                                          fontSize: 16.0)),
                                ),
                              )
                            : Container()
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          children: [
                            Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: <Color>[
                                          Color(0xFF0D47A1),
                                          Color(0xFF1976D2),
                                          Color(0xFF42A5F5),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(350, 20),
                                    padding: const EdgeInsets.all(20.0),
                                    primary: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),
                                  onPressed: () {},
                                  child: const Text('Buy Now'),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: <Color>[
                                          Color(0xFF0D47A1),
                                          Color(0xFF1976D2),
                                          Color(0xFF42A5F5),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(350, 20),
                                    padding: const EdgeInsets.all(20.0),
                                    primary: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),
                                  onPressed: () {
                                    cart.addItem(course);
                                  },
                                  child: const Text('Add to cart'),
                                )
                              ],
                            ),
                          ],
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
