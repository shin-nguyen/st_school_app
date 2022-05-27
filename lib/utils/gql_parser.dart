import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class GqlParser {
  /// provide the path relative to of the folder containing graphql queries, with no trailing or leading "/".
  /// For example, if entire project is inside the `my_app` folder, and graphql queries are inside `bin/graphql`,
  /// use `bin/graphql` as the argument.
  const GqlParser(this.gqlFolderPath);

  final String gqlFolderPath;

  /// Provided the name of the file w/out extension, will return a string of the file contents
  String gqlToString(String fileName) {
    // final pathToFile = '/${gqlFolderPath}${fileName}.graphql';
    // debugPrint(pathToFile);
    // final gqlFileText = File('blog-query.graphql').readAsLinesSync().join();
    // return gqlFileText;
    return """{
      blogs(type: "true") {
        id
        title
        summary
        content
        status
        image
        view
        topics {
            id
            name
        }
        user{
            firstName
        }
        createdTime
      }
    }
    """;
  }

  /// Return a json-encoded string of the request body for a graphql request, given the filename (without extension)
  String gqlRequestBody(String gqlFileName, Map<String, dynamic> variables) {
    final body = {"query": gqlToString(gqlFileName), "variables": variables};
    return jsonEncode(body);
  }
}
