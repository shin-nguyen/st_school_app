import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/course.dart';
import 'package:st_school_app/models/video.dart';
import 'package:st_school_app/providers/courses_notifier.dart';
import 'package:st_school_app/providers/video_notifier.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

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
  VideoPlayerController? _controller;
  List<Video> videos = [];
  int? courseId;
  @override
  void dispose() {
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    courseId = ModalRoute.of(context)!.settings.arguments as int; // is the id!
    Course course = Provider.of<CoursesNotifier>(
      context,
      listen: false,
    ).findByMeLearning(courseId!);
    videos = Provider.of<VideosNotifier>(context).getByCourse(courseId!);

    return Scaffold(
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
                                  onTap: () {},
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
                                  itemCount: videos.length,
                                  itemBuilder: (ctx, index) => GestureDetector(
                                    onTap: () {
                                      _onTapVideo(index);
                                      debugPrint(index.toString());
                                      setState(() {
                                        if (_playArea == false) {
                                          _playArea = true;
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: ListTile(
                                        leading: Text((index + 1).toString(),
                                            style: const TextStyle(
                                              color: textBlack,
                                              fontSize: 18.0,
                                            )),
                                        title: Text(videos[index].name,
                                            style: const TextStyle(
                                              color: textBlack,
                                              fontSize: 16.0,
                                            )),
                                        subtitle: Row(
                                          children: [
                                            Text(
                                                'Video - ${videos[index].duration} mins',
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14.0)),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.0),
                                              child: Icon(Icons.closed_caption,
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ),
                                        trailing: Icon(
                                          Icons.play_circle_fill_outlined,
                                          color: _isPlayingIndex == index
                                              ? primary
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ))),
                        // second tab bar viiew widget
                        _cardAbout(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  Widget _controlView(BuildContext context) {
    final noMute = (_controller?.value.volume ?? 0) > 0;
    final duration =
        _duration?.inSeconds ?? 0; //if isseconds is null then return 0
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = convertTwo(remained ~/ 60.0); // 22 ~/7 = 3
    final secs = convertTwo(remained % 60); //22%7 = 1
    return Column(mainAxisSize: MainAxisSize.min, children: [
      SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: Colors.blue[700],
          inactiveTrackColor: Colors.blue[100],
          trackShape: const RoundedRectSliderTrackShape(),
          trackHeight: 2.0,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
          thumbColor: Colors.blueAccent,
          overlayColor: Colors.blue.withAlpha(32),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
          tickMarkShape: const RoundSliderTickMarkShape(),
          activeTickMarkColor: Colors.blue[700],
          inactiveTickMarkColor: Colors.blue[100],
          valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
          valueIndicatorColor: Colors.blueAccent,
          valueIndicatorTextStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
        child: Slider(
          value: max(0, min(_progress * 100, 100)),
          min: 0,
          max: 100,
          divisions: 100,
          label: _position?.toString().split(".")[0],
          onChanged: (value) {
            setState(() {
              _progress = value * 0.01;
            });
          },
          onChangeStart: (value) {
            _controller?.pause();
          },
          onChangeEnd: (value) {
            final duration = _controller?.value.duration;
            if (duration != null) {
              var newValue = max(0, min(value, 99)) * 0.01;
              var millis = (duration.inMilliseconds * newValue).toInt();
              _controller?.seekTo(Duration(milliseconds: millis));
              _controller?.play();
            }
          },
        ),
      ),
      Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Container(
                  decoration:
                      const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 4.0,
                      color: Color.fromARGB(50, 0, 0, 0),
                    )
                  ]),
                  child: Icon(
                    noMute ? Icons.volume_up : Icons.volume_off,
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () {
                if (noMute) {
                  _controller?.setVolume(0);
                } else {
                  _controller?.setVolume(1.0);
                }
                setState(() {});
              },
            ),
            FlatButton(
                onPressed: () async {
                  final index = _isPlayingIndex - 1;
                  if (index >= 0) {
                    _initializeVideo(index);
                  } else {
                    await showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Video List'),
                        content: const Text('No videos ahead !'),
                        actions: <Widget>[
                          FlatButton(
                            child: const Text('Okay'),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                          )
                        ],
                      ),
                    );
                  }
                },
                child: const Icon(
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
                onPressed: () async {
                  final index = _isPlayingIndex + 1;
                  if (index <= videos.length - 1) {
                    _initializeVideo(index);
                  } else {
                    await showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Video List'),
                        content: const Text(
                            'You have finished watching all the videos. Congrats !'),
                        actions: <Widget>[
                          FlatButton(
                            child: const Text('Okay'),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                          )
                        ],
                      ),
                    );
                  }
                },
                child: const Icon(
                  Icons.fast_forward,
                  size: 36,
                  color: Colors.white,
                )),
            Text(
              "$mins:$secs",
              style: const TextStyle(
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0.0, 1.0),
                    blurRadius: 4.0,
                    color: Color.fromARGB(150, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return const AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
              child: Text(
            "Preparing...",
            style: TextStyle(fontSize: 20, color: Colors.white60),
          )));
    }
  }

  var _onUpdateControllerTime;
  Duration? _duration;
  Duration? _position;
  var _progress = 0.0;
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
      debugPrint("controller is null");
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint("controller can not be initialized");
      return;
    }

    _duration ??= _controller?.value.duration;
    var duration = _duration;
    if (duration == null) return;

    var position = await controller.position;
    _position = position;
    final playing = controller.value.isPlaying;
    if (playing) {
      // handle progress indicator
      if (_disposed) return;
      setState(() {
        //60 30 //45/60 = 0.75(0, 1)
        _progress = position!.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
  }

  _initializeVideo(int index) async {
    const filterString = '/api/v1/order/progress';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.get("token").toString();
    try {
      final response = await http.put(Uri.parse(baseUrl + filterString),
          headers: {
            "Authorization": token,
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: json.encode({
            'courseId': courseId,
            'video': {"id": videos[index].id}
          }));

      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to load data!');
      }
    } catch (error) {
      rethrow;
    }
    final controller = VideoPlayerController.network(videos[index].source);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});

    // ignore: avoid_single_cascade_in_expression_statements
    controller
      ..initialize().then((_) {
        old?.dispose();
        _isPlayingIndex = index;
        _duration = null;
        _position = null;
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }

  _onTapVideo(int index) {
    _initializeVideo(index);
  }

  _coureName(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 2.0),
      child: Text(
        name,
        style: const TextStyle(
          color: textBlack,
          fontSize: 20,
          fontWeight: FontWeight.w700,
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
            color: primary,
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

  _cardAbout() {
    return SingleChildScrollView(
      child: Column(
        children: const [
          ListTile(
              leading: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.more_horiz,
                  size: 18,
                  color: textBlack,
                ),
              ),
              title: Text('About this Course',
                  style: TextStyle(color: textBlack, fontSize: 16.0))),
          ListTile(
              leading: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.file_upload_outlined,
                    size: 18, color: textBlack),
              ),
              title: Text('Share this Course',
                  style: TextStyle(color: textBlack, fontSize: 16.0))),
          ListTile(
              leading: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.notes, size: 18, color: textBlack),
              ),
              title: Text('Notes',
                  style: TextStyle(color: textBlack, fontSize: 16.0))),
          ListTile(
              leading: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.format_list_bulleted,
                    size: 18, color: textBlack),
              ),
              title: Text('Resources',
                  style: TextStyle(color: textBlack, fontSize: 16.0))),
          ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Icon(Icons.doorbell_outlined, size: 18, color: textBlack),
              ),
              title: Text('Announcements',
                  style: TextStyle(color: textBlack, fontSize: 16.0))),
          ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.star_border, size: 18, color: textBlack),
              ),
              title: Text('Add course to favorites',
                  style: TextStyle(color: textBlack, fontSize: 16.0))),
          ListTile(
              leading: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.file_download_outlined,
                    size: 18, color: textBlack),
              ),
              title: Text('Archive this course',
                  style: TextStyle(color: textBlack, fontSize: 16.0))),
        ],
      ),
    );
  }
}
