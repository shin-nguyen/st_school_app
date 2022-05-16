import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/course.dart';
import 'package:st_school_app/models/video.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
import 'package:st_school_app/providers/video_notifier.dart';
import 'package:st_school_app/screens/learning/components/video.dart';
import 'package:video_player/video_player.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({Key? key}) : super(key: key);

  static const routeName = '/learning';

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  bool _playArea = false;
  bool _isPlaying = false;
  bool _disposed = false;
  int _isPlayingIndex = -1;

  bool _isInit = true;
  bool _isLoading = false;

  VideoPlayerController? _controller;
  VideosNotifier? videosNotifier;

  @override
  Widget build(BuildContext context) {
    final courseId =
        ModalRoute.of(context)!.settings.arguments as int; // is the id!
    Course course = Provider.of<CoursesNotifier>(
      context,
      listen: false,
    ).findByMeLearning(courseId);

    videosNotifier = Provider.of<VideosNotifier>(context);
    @override
    void didChangeDependencies() {
      if (_isInit) {
        setState(() {
          _isLoading = true;
        });

        Provider.of<VideosNotifier>(context)
            .fetchAndSetVideos(courseId)
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      }
      _isInit = false;
      super.didChangeDependencies();
    }

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: background,
            extendBodyBehindAppBar: true,
            body: DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: background,
                body: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // construct the profile details widget here
                      _playArea == false
                          ? Container()
                          : Column(
                              children: [
                                Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(
                                      top: 25, left: 15, right: 30, bottom: 0),
                                  child: Row(children: [
                                    InkWell(
                                      onTap: () {
                                        debugPrint("Tapped");
                                      },
                                      child: const Icon(
                                        Icons.arrow_back_sharp,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    const Icon(
                                      Icons.info_outline,
                                      size: 20,
                                      color: Colors.black,
                                    )
                                  ]),
                                ),
                                _playView(context),
                                _controlView(context),
                              ],
                            ),
                      _coureName(course.name),

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
                      _tabBar(),
                      // create widgets for each tab bar here
                      Expanded(
                        child: TabBarView(
                          children: [
                            // first tab bar view widget
                            SingleChildScrollView(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: videosNotifier?.getVideos.length,
                                itemBuilder: (ctx, index) => Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ListTile(
                                    leading: Text((index + 1).toString(),
                                        style: const TextStyle(
                                          color: textBlack,
                                          fontSize: 18.0,
                                        )),
                                    title: Text(
                                        videosNotifier!.getVideos[index].name
                                            .toString(),
                                        style: const TextStyle(
                                          color: textBlack,
                                          fontSize: 16.0,
                                        )),
                                    subtitle: Row(
                                      children: [
                                        Text(
                                            'Video - ${videosNotifier?.getVideos[index].time} mins',
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14.0)),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 4.0),
                                          child: Icon(Icons.closed_caption,
                                              color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _onTapVideo(index);
                                            if (_playArea == false) {
                                              _playArea = true;
                                            }
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.play_circle_fill_outlined,
                                          color: Colors.grey,
                                        )),
                                  ),
                                ),
                              ),
                            )),
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
                                              color: textBlack,
                                              fontSize: 16.0))),
                                  ListTile(
                                      leading: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.file_upload_outlined,
                                            size: 18, color: textBlack),
                                      ),
                                      title: Text('Share this Course',
                                          style: TextStyle(
                                              color: textBlack,
                                              fontSize: 16.0))),
                                  ListTile(
                                      leading: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.notes,
                                            size: 18, color: textBlack),
                                      ),
                                      title: Text('Notes',
                                          style: TextStyle(
                                              color: textBlack,
                                              fontSize: 16.0))),
                                  ListTile(
                                      leading: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.format_list_bulleted,
                                            size: 18, color: textBlack),
                                      ),
                                      title: Text('Resources',
                                          style: TextStyle(
                                              color: textBlack,
                                              fontSize: 16.0))),
                                  ListTile(
                                      leading: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.doorbell_outlined,
                                            size: 18, color: textBlack),
                                      ),
                                      title: Text('Announcements',
                                          style: TextStyle(
                                              color: textBlack,
                                              fontSize: 16.0))),
                                  ListTile(
                                      leading: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.star_border,
                                            size: 18, color: textBlack),
                                      ),
                                      title: Text('Add course to favorites',
                                          style: TextStyle(
                                              color: textBlack,
                                              fontSize: 16.0))),
                                  ListTile(
                                      leading: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                            Icons.file_download_outlined,
                                            size: 18,
                                            color: textBlack),
                                      ),
                                      title: Text('Archive this course',
                                          style: TextStyle(
                                              color: textBlack,
                                              fontSize: 16.0))),
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

  @override
  void dispose() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  var _onUpdateControllerTime;

  void _onControllerUpdate() async {
    if (_disposed) {
      return;
    }
    _onUpdateControllerTime = 0;

    final now = DateTime.now().millisecondsSinceEpoch;

    if (_onUpdateControllerTime > now) {
      return;
    }
    _onUpdateControllerTime = now + 500;

    final controller = _controller;
    if (controller == null) {
      debugPrint('Controller is null');
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("controller can not be initialzied");
      return;
    }

    final playing = controller.value.isPlaying;
    _isPlaying = playing;
  }

  _initializedVideo(int index) async {
    final controller =
        VideoPlayerController.network(videosNotifier!.getVideos[index].source);
    final old = _controller;
    _controller = controller;

    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});

    controller
      ..initialize().then((_) {
        old?.dispose();

        _isPlayingIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }

  _onTapVideo(int index) {
    _initializedVideo(index);
  }

  Widget _controlView(BuildContext context) {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        color: primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
                onPressed: () {
                  final index = _isPlayingIndex - 1;
                  if (index >= 0) {
                    _initializedVideo(index);
                  } else {
                    Get.snackbar("Video List ", "",
                        snackPosition: SnackPosition.BOTTOM,
                        icon: Icon(
                          Icons.face,
                          size: 30,
                          color: Colors.white,
                        ),
                        backgroundColor: primary,
                        colorText: textBlack,
                        messageText: Text(
                          "No videos ahead",
                          style: TextStyle(fontSize: 20, color: textBlack),
                        ));
                  }
                },
                child: Icon(
                  Icons.fast_rewind,
                  size: 36,
                  color: Colors.white,
                )),
            FlatButton(
                onPressed: () async {
                  if (_isPlaying) {
                    setState(() {
                      _isPlaying = false;
                    });
                    _controller?.pause();
                  } else {
                    setState(() {
                      _isPlaying = true;
                    });
                    _controller?.play();
                  }
                },
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 36,
                  color: Colors.white,
                )),
            FlatButton(
                onPressed: () {
                  final index = _isPlayingIndex + 1;
                  if (videosNotifier!.getVideos.length - 1 >= index) {
                    _initializedVideo(index);
                  } else {
                    debugPrint(
                        "You have finished watching all the videos. Congrats!");
                    Get.snackbar("Video List ", "",
                        snackPosition: SnackPosition.BOTTOM,
                        icon: Icon(
                          Icons.face,
                          size: 30,
                          color: Colors.white,
                        ),
                        backgroundColor: primary,
                        colorText: textBlack,
                        messageText: Text(
                          "You have finished watching all the videos. Congrats!",
                          style: TextStyle(fontSize: 20, color: textBlack),
                        ));
                  }
                },
                child: Icon(
                  Icons.fast_forward,
                  size: 36,
                  color: Colors.white,
                ))
          ],
        ));
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: Text(
            "Preparing...",
            style: TextStyle(
              fontSize: 20,
              color: textBlack,
            ),
          ),
        ),
      );
    }
  }

  _coureName(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 2.0),
      child: Text(
        name,
        style: const TextStyle(
          color: textBlack,
          fontSize: 20,
        ),
      ),
    );
  }

  _tabBar() {
    return SizedBox(
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
    );
  }
}
