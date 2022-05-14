import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/course.dart';
import 'package:st_school_app/providers/cart_notifier.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
import 'package:st_school_app/providers/video_notifier.dart';
import 'package:st_school_app/screens/learning/components/Learning_item.dart';
import 'package:st_school_app/screens/learning/components/video.dart';
import 'package:st_school_app/widgets/app_text.dart';
import 'package:video_player/video_player.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({Key? key}) : super(key: key);

  static const routeName = '/learning';

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  // final RestorableIntN _indexSelected = RestorableIntN(null);
  // bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    final courseId =
        ModalRoute.of(context)!.settings.arguments as int; // is the id!

    Course course = Provider.of<CoursesNotifier>(
      context,
      listen: false,
    ).findByMeLearning(courseId);

    return Scaffold(
        backgroundColor: background,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: background,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // construct the profile details widget here
                  Container(
                    height: 300,
                    child: ChewieListItem(
                      videoPlayerController: VideoPlayerController.network(
                        'https://res.cloudinary.com/qscloud/video/upload/v1641180341/st-school/videos/C%C3%A0i%20%C4%91%E1%BA%B7t%20m%C3%B4i%20tr%C6%B0%E1%BB%9Dng.mp4.mp4',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 16.0, bottom: 2.0),
                    child: Text(
                      course.name,
                      style: const TextStyle(
                        color: textBlack,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 16),
                    child: Text(
                      course.lecturer,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  // the tab bar with two items
                  SizedBox(
                    height: 50,
                    child: AppBar(
                      backgroundColor: background,
                      bottom: TabBar(
                        labelColor: Colors.black,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                          color: Colors.grey,
                        ),
                        unselectedLabelColor: Colors.black,
                        tabs: const [
                          Tab(
                            text: 'Lectures',
                          ),
                          Tab(
                            text: 'More',
                          ),
                        ],
                      ),
                    ),
                  ),

                  // create widgets for each tab bar here
                  Expanded(
                    child: TabBarView(
                      children: [
                        // first tab bar view widget
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: FutureBuilder(
                              future: Provider.of<VideosNotifier>(context,
                                      listen: false)
                                  .fetchAndSetVideos(courseId),
                              builder: (ctx, dataSnapshot) {
                                if (dataSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  if (dataSnapshot.error != null) {
                                    // print(dataSnapshot.error);
                                    // ...
                                    // Do error handling stuff
                                    return const Center(
                                      child: Text('An error occurred!'),
                                    );
                                  } else {
                                    return Consumer<VideosNotifier>(
                                      builder: (ctx, videos, child) =>
                                          ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: videos.getVideos.length,
                                        itemBuilder: (ctx, i) => Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: LearningItem(
                                            id: videos.getVideos[i].id,
                                            index: i,
                                            name: videos.getVideos[i].name,
                                            source: videos.getVideos[i].source,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ),

                        // second tab bar viiew widget
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.more_horiz,
                                      size: 18,
                                      color: textBlack,
                                    ),
                                  ),
                                  title: Text('About this Course',
                                      style: TextStyle(
                                          color: textBlack, fontSize: 16.0))),
                              ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.file_upload_outlined,
                                        size: 18, color: textBlack),
                                  ),
                                  title: Text('Share this Course',
                                      style: TextStyle(
                                          color: textBlack, fontSize: 16.0))),
                              ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.notes,
                                        size: 18, color: textBlack),
                                  ),
                                  title: Text('Notes',
                                      style: TextStyle(
                                          color: textBlack, fontSize: 16.0))),
                              ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.format_list_bulleted,
                                        size: 18, color: textBlack),
                                  ),
                                  title: Text('Resources',
                                      style: TextStyle(
                                          color: textBlack, fontSize: 16.0))),
                              ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.doorbell_outlined,
                                        size: 18, color: textBlack),
                                  ),
                                  title: Text('Announcements',
                                      style: TextStyle(
                                          color: textBlack, fontSize: 16.0))),
                              ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.star_border,
                                        size: 18, color: textBlack),
                                  ),
                                  title: Text('Add course to favorites',
                                      style: TextStyle(
                                          color: textBlack, fontSize: 16.0))),
                              ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.file_download_outlined,
                                        size: 18, color: textBlack),
                                  ),
                                  title: Text('Archive this course',
                                      style: TextStyle(
                                          color: textBlack, fontSize: 16.0))),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));

    /*
    
    Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/course_1_cover.png'),
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(
                              Colors.black26, BlendMode.darken)))),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, top: 16.0, bottom: 8.0),
                child: Text('Introduction to Coding with Ruby',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('Dan Draper',
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (ctx, i) {
                    return IgnorePointer(
                      ignoring: true,
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        expandedAlignment: Alignment.topLeft,
                        childrenPadding: EdgeInsets.only(left: 16.0),
                        trailing: Icon(Icons.add, color: Colors.blue),
                        title: Text(
                            'Section 1 - Day 1 - Beginner - Working with Variables in Python to Manage Data',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0)),
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 10,
                              itemBuilder: (ctx, i) {
                                return ListTile(
                                  leading: Text('1',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18.0)),
                                  title: Text(
                                      'What you\'re going to get from this course',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0)),
                                  subtitle: Row(
                                    children: [
                                      Text('Video - 03:27 mins',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Icon(Icons.closed_caption,
                                            color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  trailing: Icon(
                                      Icons.play_circle_fill_outlined,
                                      color: Colors.blue),
                                );
                              })
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
    
    */
  }

  // @override
  // String get restorationId => 'choice_chip_demo';

  // @override
  // void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
  //   registerForRestoration(_indexSelected, 'choice_chip');
  // }

  // @override
  // void dispose() {
  //   _indexSelected.dispose();
  //   super.dispose();
  // }
}
