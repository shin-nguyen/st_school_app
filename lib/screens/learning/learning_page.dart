import 'package:flutter/material.dart';
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // construct the profile details widget here
              Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/course_clone.jpg'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black26, BlendMode.darken)))),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 2.0),
                child: Text('Introduction to Coding with Rubyyy',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 16),
                child: Text('Dan Draper',
                    style: TextStyle(color: Colors.grey, fontSize: 16)),
              ),

              // the tab bar with two items
              SizedBox(
                height: 50,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  bottom: TabBar(
                    tabs: [
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
                        child: ListView.builder(
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
                                  title: Text(
                                      'Section 1 - Day 1 - Beginner - Working with Variables in Python to Manage Data',
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 15.0)),
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: 10,
                                        itemBuilder: (ctx, i) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: ListTile(
                                              leading: Text((i + 1).toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0)),
                                              title: Text(
                                                  'What you\'re going to get from this course',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0)),
                                              subtitle: Row(
                                                children: [
                                                  Text('Video - 03:27 mins',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14.0)),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4.0),
                                                    child: Icon(
                                                        Icons.closed_caption,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                              trailing: Icon(
                                                  Icons
                                                      .play_circle_fill_outlined,
                                                  color: Colors.blue),
                                            ),
                                          );
                                        })
                                  ],
                                ),
                              );
                            }),
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
                                  color: Colors.white,
                                ),
                              ),
                              title: Text('About this Course',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0))),
                          ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.file_upload_outlined,
                                    size: 18, color: Colors.white),
                              ),
                              title: Text('Share this Course',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0))),
                          ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.notes,
                                    size: 18, color: Colors.white),
                              ),
                              title: Text('Notes',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0))),
                          ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.format_list_bulleted,
                                    size: 18, color: Colors.white),
                              ),
                              title: Text('Resources',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0))),
                          ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.doorbell_outlined,
                                    size: 18, color: Colors.white),
                              ),
                              title: Text('Announcements',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0))),
                          ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.star_border,
                                    size: 18, color: Colors.white),
                              ),
                              title: Text('Add course to favorites',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0))),
                          ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.file_download_outlined,
                                    size: 18, color: Colors.white),
                              ),
                              title: Text('Archive this course',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0))),
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
    );

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
