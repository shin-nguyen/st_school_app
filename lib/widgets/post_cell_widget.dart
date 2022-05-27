import 'package:flutter/material.dart';
import 'package:st_school_app/models/blog.dart';

class PostCellWidget extends StatelessWidget {
  final Blog blog;
  final Function onClick;
  PostCellWidget({
    required this.blog,
    required this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick(),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            height: 75,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                blog.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${blog.user}, ${blog.createdTime}',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
