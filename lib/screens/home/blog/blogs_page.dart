import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:st_school_app/constants/system_constants.dart';
import 'package:st_school_app/models/blog.dart';
import 'package:st_school_app/providers/blogs_notifier.dart';
import 'package:st_school_app/screens/home/blog/components/blog_details_page.dart';
import 'package:st_school_app/widgets/custom_heading.dart';
import 'package:st_school_app/widgets/custome_search_field.dart';
import 'package:st_school_app/widgets/post_cell_widget.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<BlogsNotifier>(context).fetchAndSetBlogs().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  String query = '';
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<String> blogTypes = [
      "All",
      "Fashion",
      "UI/UX Design",
      "Health",
      "Technology",
      "Sports",
    ];

    final blog = Provider.of<BlogsNotifier>(context);

    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(appPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: spacer - 1.0,
                  ),

                  //Header
                  const CustomHeading(
                    title: "Blogs for you",
                    subTitle: "Seek for your preference",
                    color: secondary,
                  ),
                  const SizedBox(height: spacer),

                  // search
                  CustomSearchField(
                    text: query,
                    hintText: 'Search for articles, author, and tags',
                    onChanged: blog.findByQuery,
                  ),
                  const SizedBox(
                    height: miniSpacer,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        blogTypes.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(right: 24),
                              child: Column(
                                children: [
                                  Text(
                                    blogTypes[index],
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: selectedIndex == index
                                            ? secondary
                                            : secondary.withOpacity(0.4),
                                        fontWeight: selectedIndex == index
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                                  ),
                                  Container(
                                    height: 4.0,
                                    width: 4.0,
                                    margin: EdgeInsets.only(top: 8.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        color: selectedIndex == index
                                            ? secondary
                                            : Colors.transparent),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: spacer,
                  ),
                  Column(
                    children: List.generate(blog.getBlogs.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 4,
                          right: 4,
                        ),
                        child: Column(
                          children: [
                            PostCellWidget(
                              blog: blog.getBlogs[index],
                              onClick: () {},
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: smallSpacer),
                  Text(
                    'Writing Contest',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 80,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          width: 130,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/writing_1.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: 130,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/writing_2.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: 130,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/writing_3.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
