import 'dart:async';

import 'package:blogpost/Blogs/datasource/modal.dart';

import 'mock_Iblog_repo.dart';

class MockBlogRepo implements IBlogRepo {
  final List<Blog> _ds = [];
  late final StreamController<List<Blog>> _controller =
      StreamController.broadcast();

  Future<void> addBlog(Blog blog) async {
    await Future.delayed(const Duration(seconds: 1));
    _ds.add(blog);
    _controller.add(_ds);
  }

  Future<bool> deleteBlog(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    _matcher(Blog element) => element.id == id;
    if (_ds.any(_matcher)) {
      _ds.removeWhere(_matcher);
      _controller.add(_ds);
      return true;
    }
    return false;
  }

  Stream<List<Blog>> fetchAllBlogs() async* {
    yield* _controller.stream;
  }

  void dispose() {
    _controller.close();
  }
}
