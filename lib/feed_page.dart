import 'package:blogpost/Auth/auth_repo.dart';
import 'package:blogpost/blog_details.dart';
import 'package:blogpost/create_blog.dart';
import 'package:flutter/material.dart';

import 'Blogs/modal.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Blog> allBlogs = <Blog>[];

  Widget blogToWidgetMapper(Blog blog) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: ListTile(
          leading: Image.network(blog.imageUrl),
          subtitle: Text('by ${blog.author.email}'),
          tileColor: Colors.white,
          minVerticalPadding: 10,
          title: Text(blog.title),
          onTap: (() async {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlogDetails(
                      blog: blog,
                    )));
            fetchAllBlogs();
          }),
        ),
      );

  @override
  void initState() {
    super.initState();
    fetchAllBlogs().then((value) => setState(
          () => allBlogs = value,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 28, 28, 28),
        title: const Text('Blog Feed'),
      ),
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 64.0),
              child: SingleChildScrollView(
                child: Column(
                  children: allBlogs.map(blogToWidgetMapper).toList(),
                ),
              )),
          RawMaterialButton(
              shape: const StadiumBorder(),
              fillColor: Colors.limeAccent,
              onPressed: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateBlog()),
                );
              }),
              child: const Icon(Icons.add))
        ],
      ),
    );
  }
}
