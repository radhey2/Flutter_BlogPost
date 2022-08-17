import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Blogs/modal.dart';

class AuthRepository {
  static AuthRepository? _instance;
  AuthRepository._(); // Private Constructor
  factory AuthRepository() {
    _instance ??= AuthRepository._(); // ??= is called Elvis Operator
    return _instance!;
  }

  Future signIn({required String email, required String password}) async {
    final response = await http.post(
        Uri.parse('https://spiceblogserver-production.up.railway.app/login'),
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ));

    return response.statusCode == 200;
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final response = await http.post(
      Uri.parse('https://spiceblogserver-production.up.railway.app/signup'),
      body: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
      },
    );

    return response.statusCode == 200;
  }
}

Future fetchAllBlogs() async {
  final response = await http.get(
    Uri.parse(
        'https://spiceblogserver-production.up.railway.app/fetchAllBlogs'),
  );
  try {
    final data = json.decode(response.body);
    return data.map<Blog>((e) => Blog.fromJson(e)).toList();
  } catch (_) {
    return <Blog>[];
  }
}
