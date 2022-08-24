import 'dart:convert';

import 'package:blogpost/Blogs/datasource/modal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Blog', () {
    test('equality Testing', () {
      final blog = Blog(
        title: "title",
        content: "content",
        imageUrl: "imageUrl",
        author: const Author(email: "email", photoUrl: "photoUrl"),
        updatedAt: DateTime(2022),
      );

      final blog2 = Blog(
        title: "title",
        content: "content",
        imageUrl: "imageUrl",
        author: const Author(email: "email", photoUrl: "photoUrl"),
        updatedAt: DateTime(2022),
      );

      expect(blog, blog2);
    });

    test('.fromjson', () {
      const jsonStr = '''
        {
          "id" : 17,
          "title" : "title",
          "content": "content",
          "imageurl": "imageUrl",
          "email" : "email",
          "updatedat" : "2022-08-24T04:49:39Z"
        }
        ''';

      final json = jsonDecode(jsonStr);

      final blog = Blog.fromJson(json);
      expect(blog.author.email, "email");
      expect(blog.author, const Author(email: "email", photoUrl: ""));
    });
  });
}
