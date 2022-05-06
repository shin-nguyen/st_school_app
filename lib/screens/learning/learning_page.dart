import 'package:flutter/material.dart';
import 'package:st_school_app/screens/learning/components/video.dart';
import 'package:st_school_app/widgets/app_text.dart';
import 'package:st_school_app/widgets/appbar.dart';
import 'package:video_player/video_player.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({Key? key}) : super(key: key);

  static const routeName = '/learning';

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> with RestorationMixin {
  final RestorableIntN _indexSelected = RestorableIntN(null);
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Stack(children: [
              const CustomeAppBar(),
              const SizedBox(height: 10),
              Positioned(
                  left: 15,
                  right: 15,
                  top: 15,
                  child: Container(
                      height: 300,
                      child: ChewieListItem(
                        videoPlayerController: VideoPlayerController.network(
                          'https://res.cloudinary.com/qscloud/video/upload/v1641180341/st-school/videos/C%C3%A0i%20%C4%91%E1%BA%B7t%20m%C3%B4i%20tr%C6%B0%E1%BB%9Dng.mp4.mp4',
                        ),
                      ))),
              const Divider(
                color: Colors.grey,
                height: 20,
                thickness: 1,
                indent: 20,
                endIndent: 0,
              ),
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
                              color: Color.fromARGB(255, 5, 5, 5)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          AppText(
                              text: "Kai Akatsuki",
                              size: 13,
                              color: Color.fromARGB(255, 94, 85, 85)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          AppText(
                              text: "Lectures",
                              size: 18,
                              color: Color.fromARGB(255, 44, 44, 44)),
                        ],
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView(
                          restorationId: 'list_view',
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          children: [
                            for (int index = 1; index < 21; index++)
                              ListTile(
                                // leading: ExcludeSemantics(
                                //   child: Text('$index'),
                                // ),
                                trailing: Checkbox(
                                  checkColor: Colors.white,
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                                title: AppText(
                                  text: index.toString() +
                                      ".This is a video " +
                                      index.toString() +
                                      " of course",
                                  size: 14,
                                  color: Color.fromARGB(255, 44, 43, 43),
                                ),
                                subtitle: AppText(
                                  text: "Video | 5:22 mins",
                                  size: 10,
                                  color: Colors.black54,
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ])));
  }

  @override
  String get restorationId => 'choice_chip_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_indexSelected, 'choice_chip');
  }

  @override
  void dispose() {
    _indexSelected.dispose();
    super.dispose();
  }
}
