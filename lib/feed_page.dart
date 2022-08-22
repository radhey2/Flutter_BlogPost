import 'package:blogpost/Auth/auth_repo.dart';
import 'package:blogpost/blog_details.dart';
import 'package:blogpost/create_blog.dart';
import 'package:flutter/material.dart';

import 'Blogs/blog_repository.dart';
import 'Blogs/modal.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Blog> allBlogs = <Blog>[];
  final BlogRepository repo = BlogRepository();

  bool _isLoading = false;

  Future<void> fetchAllBlogs() async {
    setState(() {
      _isLoading = true;
    });
    final List<Blog> blogs = await repo.fetchAllBlogs();
    setState(() {
      allBlogs = blogs;
      _isLoading = false;
    });
  }

  Future<void> deleteBlog(int id) async {
    repo.deleteBlog(id);
  }

  Widget blogToWidgetMapper(Blog blog) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: ListTile(
          leading: Image.network(blog.imageUrl),
          subtitle: Text('by ${blog.author.email}'),
          tileColor: Colors.white,
          minVerticalPadding: 10,
          title: Text(blog.title),
          trailing: IconButton(
            onPressed: (() async {
              final isdeleted = await repo.deleteBlog(blog.id!);
              if (isdeleted) {
                await fetchAllBlogs();
              }
            }),
            icon: const Icon(Icons.delete),
          ),
          onTap: (() async {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BlogDetails(
                      blog: blog,
                    )));
            await fetchAllBlogs();
          }),
        ),
      );

  @override
  void initState() {
    super.initState();
    fetchAllBlogs();
  }

  // void refreshBlogs() {
  //   fetchAllBlogs().then((value) => setState(
  //         () => allBlogs = value,
  //       ));
  // }

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
              onPressed: (() async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateBlog()),
                );
                fetchAllBlogs();
              }),
              child: const Icon(Icons.add))
        ],
      ),
    );
  }
}
