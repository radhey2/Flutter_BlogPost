import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'modal.dart';

class BlogRepository {
  static BlogRepository? _instance;
  BlogRepository._(); // Private Constructor
  factory BlogRepository() {
    _instance ??= BlogRepository._(); // ??= is called Elvis Operator
    return _instance!;
  }

  Future<List<Blog>> fetchAllBlogs() async {
    final res = await http.get(
      Uri.parse('https://spiceblogserver-production.up.railway.app/addBlog'),
    );
    try {
      final data = json.decode(res.body);
      return data.map<Blog>((e) => Blog.fromJson(e)).toList();
    } catch (_) {
      return <Blog>[];
    }
  }

  Future<void> addBlog(Blog blog) async {
    final res = await http.post(
        Uri.parse('https://spiceblogserver-production.up.railway.app/addblog'),
        body: blog.toJson());
    log(res.body);
  }
}
