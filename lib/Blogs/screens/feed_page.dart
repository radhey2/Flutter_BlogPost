import 'package:blogpost/Blogs/screens/blog_details.dart';
import 'package:blogpost/Blogs/screens/create_blog.dart';
import 'package:flutter/material.dart';

import '../datasource/modal.dart';
import '../logic/blog_feed_bloc.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late final BlogFeedBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlogFeedBloc();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 95, 76, 76),
        title: const Text('Blog Feed'),
        actions: [
          TextButton(
              onPressed: (() {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreateBlog(),
                  ),
                );
              }),
              child: const Text('Add Blog'))
        ],
      ),
      body: StreamBuilder<List<Blog>>(
          stream: bloc.blogs.obs$,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            final blogs = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                final blog = blogs[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlogDetails(blog: blog),
                      ),
                    );
                  },
                  trailing: IconButton(
                      onPressed: () => bloc.deleteBlog(blog.id!),
                      icon: const Icon(Icons.delete)),
                  leading: Image.network(
                    blog.imageUrl,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  title: Text(blog.title),
                  subtitle: Text('by ${blog.author.email}'),
                );
              },
              itemCount: blogs.length,
            );
          }),
    );
  }
}
