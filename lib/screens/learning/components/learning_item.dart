import 'package:flutter/material.dart';
import 'package:st_school_app/constants/system_constants.dart';

class LearningItem extends StatefulWidget {
  final int index;
  final int id;
  final String name;
  final String source;

  const LearningItem({
    Key? key,
    required this.index,
    required this.id,
    required this.name,
    required this.source,
  }) : super(key: key);

  @override
  _LearningItemState createState() => _LearningItemState();
}

class _LearningItemState extends State<LearningItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text((widget.index + 1).toString(),
          style: const TextStyle(
            color: textBlack,
            fontSize: 18.0,
          )),
      title: Text(widget.name,
          style: const TextStyle(
            color: textBlack,
            fontSize: 16.0,
          )),
      subtitle: Row(
        children: const [
          Text('Video - 03:27 mins',
              style: TextStyle(color: Colors.grey, fontSize: 14.0)),
          Padding(
            padding: EdgeInsets.only(left: 4.0),
            child: Icon(Icons.closed_caption, color: Colors.grey),
          )
        ],
      ),
      trailing: const Icon(
        Icons.play_circle_fill_outlined,
        color: Colors.blue,
      ),
    );
  }
}
