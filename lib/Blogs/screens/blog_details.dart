import 'package:blogpost/Blogs/datasource/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../common_widget.dart';

class BlogDetails extends StatelessWidget {
  final Blog blog;
  const BlogDetails({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          blog.title,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(blog.updatedAt.toIso8601String()),
                const SizedBox(
                  width: 48,
                ),
                Text('by ${blog.author.email}')
              ],
            ),
            const VerticalSpacing(),
            Image.network(blog.imageUrl),
            const VerticalSpacing(),
            Html(data: blog.content),
          ],
        ),
      ),
    );
  }
}
