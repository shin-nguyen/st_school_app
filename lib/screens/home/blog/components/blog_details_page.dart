import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/blog.dart';
import 'package:st_school_app/providers/blogs_notifier.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_share/flutter_share.dart';

class BlogDetailsPage extends StatefulWidget {
  const BlogDetailsPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/blog-detail';
  @override
  State<BlogDetailsPage> createState() => _BlogDetailsPageState();
}

class _BlogDetailsPageState extends State<BlogDetailsPage> {
  StreamController<String> controllerUrl = StreamController<String>();

  void generateLink(
      BranchUniversalObject buo, BranchLinkProperties lp, Blog blog) async {
    BranchResponse response =
        await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);
    if (response.success) {
      await share(blog, response.result);
      //debugPrint(response.result);
      controllerUrl.sink.add('${response.result}');
    } else {
      controllerUrl.sink
          .add('Error : ${response.errorCode} - ${response.errorMessage}');
    }
  }

  Future<void> share(Blog blog, String link) async {
    await FlutterShare.share(
      title: blog.title,
      linkUrl: link,
    );
  }

  var blogId = -1;

  Future<void> _likeBlog() async {
    try {
      await Provider.of<BlogsNotifier>(context, listen: false)
          .updateLike(blogId);
      setState(() {});
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('An error occurred!'),
          content: const Text('Something went wrong.'),
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
  }

  @override
  Widget build(BuildContext context) {
    blogId = ModalRoute.of(context)?.settings.arguments as int; // is the id!

    final blog = Provider.of<BlogsNotifier>(
      context,
      listen: false,
    ).findById(blogId);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                color: Colors.grey[200],
                child: IconButton(
                  icon: const Icon(
                    Icons.favorite_outline,
                    size: 20,
                  ),
                  color: blog.love ? Colors.red : Colors.grey,
                  onPressed: () {
                    _likeBlog();
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                color: Colors.grey[200],
                child: IconButton(
                  icon: const Icon(
                    Icons.share_outlined,
                    size: 20,
                  ),
                  color: Colors.grey,
                  onPressed: () async {
                    BranchLinkProperties lp = BranchLinkProperties(
                        channel: 'facebook',
                        feature: 'sharing',
                        stage: 'new share',
                        campaign: 'xxxxx',
                        tags: ['one', 'two', 'three'])
                      ..addControlParam('referring_user_id', 'asdf');
                    lp.addControlParam('\$uri_redirect_mode', '1');
                    return generateLink(
                      BranchUniversalObject(
                          canonicalIdentifier: 'flutter/branch',
                          canonicalUrl: 'https://flutter.dev',
                          title: 'Blogs Plugin',
                          imageUrl:
                              'https://res.cloudinary.com/qscloud/image/upload/v1653703118/st-school/images/image_picker6898674863682973209.jpg.jpg',
                          contentDescription: 'Blogs Pages',
                          contentMetadata: BranchContentMetaData()
                            ..addCustomMetadata('key', blogId),
                          keywords: ['Plugin', 'Branch', 'Flutter'],
                          publiclyIndex: true,
                          locallyIndex: true,
                          expirationDateInMilliSec: DateTime.now()
                              .add(const Duration(days: 365))
                              .millisecondsSinceEpoch),
                      lp,
                      blog,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.only(top: miniSpacer),
          child: ListView(
            children: [
              // ElevatedButton(
              //     onPressed: () {
              //       BranchLinkProperties lp = BranchLinkProperties(
              //           channel: 'facebook',
              //           feature: 'sharing',
              //           stage: 'new share',
              //           campaign: 'xxxxx',
              //           tags: ['one', 'two', 'three'])
              //         ..addControlParam('referring_user_id', 'asdf');
              //       lp.addControlParam('\$uri_redirect_mode', '1');
              //       return generateLink(
              //         BranchUniversalObject(
              //             canonicalIdentifier: 'flutter/branch',
              //             canonicalUrl: 'https://flutter.dev',
              //             title: 'Blogs Plugin',
              //             imageUrl:
              //                 'https://res.cloudinary.com/qscloud/image/upload/v1653703118/st-school/images/image_picker6898674863682973209.jpg.jpg',
              //             contentDescription: 'Blogs Pages',
              //             contentMetadata: BranchContentMetaData()
              //               ..addCustomMetadata('key', blogId),
              //             keywords: ['Plugin', 'Branch', 'Flutter'],
              //             publiclyIndex: true,
              //             locallyIndex: true,
              //             expirationDateInMilliSec: DateTime.now()
              //                 .add(const Duration(days: 365))
              //                 .millisecondsSinceEpoch),
              //         lp,
              //       );
              //     },
              //     child: Text(
              //       "Generate Link",
              //       style: TextStyle(
              //         fontSize: 20.0,
              //       ),
              //     )),
              Text(
                blog.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                            text: blog.user,
                          ),
                        ],
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 14.0)),
                  ),
                  const SizedBox(
                    width: miniSpacer,
                  ),
                  RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                            text: blog.createdTime,
                          ),
                        ],
                        style: const TextStyle(
                            color: Colors.grey, fontSize: 14.0)),
                  ),
                  const SizedBox(
                    width: miniSpacer,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    children: [
                      const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.grey,
                        size: 18,
                      ),
                      Text(
                        blog.view.toString() + ' Views',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w100,
                        ),
                      )
                    ],
                  ),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.grey,
                        size: 18,
                      ),
                      Text(
                        blog.recordLove.toString() + ' Likes',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w100,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  blog.image,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Html(
                data: blog.content,
              )
            ],
          ),
        ),
      ),
    );
  }
}
