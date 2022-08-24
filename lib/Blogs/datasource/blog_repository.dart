import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'modal.dart';

abstract class IBlogRepository {
  Stream<List<Blog>> fetchAllBlogs();
  Future<void> addBlog(Blog blog);
  Future<bool> deleteBlog(int id);
}

class BlogRepository implements IBlogRepository {
  static BlogRepository? _instance;
  WebSocketChannel? _channel;
  BlogRepository._(); // Private Constructor
  factory BlogRepository() {
    _instance ??= BlogRepository._(); // ??= is called Elvis Operator

    _instance!._channel ??= WebSocketChannel.connect(
        Uri.parse('wss://spiceblogserver-production.up.railway.app/ws'));
    return _instance!;
  }

  Stream<List<Blog>> fetchAllBlogs() async* {
    yield* _instance!._channel!.stream.map((event) {
      try {
        final data = json.decode(event);
        return data.map<Blog>((e) => Blog.fromJson(e)).toList();
      } catch (_) {
        return <Blog>[];
      }
    });
  }

  Future<void> addBlog(Blog blog) async {
    final res = await http.post(
        Uri.parse('https://spiceblogserver-production.up.railway.app/addBlog'),
        body: jsonEncode(blog.toJson()));
    log(res.body);
  }

  Future<bool> deleteBlog(int id) async {
    final res = await http.delete(
      Uri.parse(
          'https://spiceblogserver-production.up.railway.app/deleteBlog?id=$id'),
    );
    return res.statusCode == 200;
  }
}
