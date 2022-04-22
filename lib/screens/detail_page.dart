import 'package:flutter/material.dart';
import 'package:st_school_app/widgets/app_text.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int gottenStars = 4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
                child: Container(
              width: double.maxFinite,
              height: 330,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://res.cloudinary.com/qscloud/image/upload/v1635049180/st-school/images/html.png.png"),
                      fit: BoxFit.cover)),
            )),
            Positioned(
                left: 15,
                top: 15,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () => {Navigator.pop(context)},
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white)
                  ],
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        AppText(
                            text: "Learning HTML",
                            size: 25,
                            color: Color.fromARGB(255, 248, 175, 71)),
                        AppText(
                            text: "\$200",
                            size: 25,
                            color: Color.fromARGB(255, 8, 186, 55)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        AppText(
                            text: "Lecturer: Kai Akatsuki",
                            size: 13,
                            color: Color.fromARGB(255, 94, 85, 85)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(5, (index) {
                            return Icon(Icons.star,
                                color: index < gottenStars
                                    ? Colors.yellow
                                    : Colors.black);
                          }),
                        ),
                        SizedBox(width: 10),
                        Text("5.0")
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        AppText(
                            text: "Description", size: 18, color: Colors.black),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        AppText(
                          text: "Language : English",
                          size: 13,
                          color: Color.fromARGB(255, 94, 85, 85),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    const Expanded(
                      child: Text(
                        'Start learning HTML with the w3schools course and lay the foundations of your Web Development skills. HTML is the standard markup language for Web pages. With HTML you can create your own Website.This is a structured and interactive version of the w3schools HTML Tutorial together with the w3schools certification. ',
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    SizedBox(height: 10),
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
                      child: Stack(
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
                              minimumSize: Size(350, 20),
                              padding: const EdgeInsets.all(20.0),
                              primary: Color.fromARGB(255, 255, 255, 255),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            onPressed: () {},
                            child: const Text('Enroll Free'),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
