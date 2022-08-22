import 'dart:convert';

import 'package:blogpost/Auth/modal.dart';
import 'package:http/http.dart' as http;

import '../Blogs/modal.dart';

class AuthRepository {
  static AuthRepository? _instance;
  AuthRepository._(); // Private Constructor
  factory AuthRepository() {
    _instance ??= AuthRepository._(); // ??= is called Elvis Operator
    return _instance!;
  }

  User? _user;
  User? get currentUser => _user;

  Future signIn({required String email, required String password}) async {
    final response = await http.post(
        Uri.parse('https://spiceblogserver-production.up.railway.app/login'),
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ));

    if (response.statusCode == 200) {
      _user = User.fromJson(jsonDecode(response.body));
      return true;
    }
    return false;
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final response = await http.post(
        Uri.parse('https://spiceblogserver-production.up.railway.app/signup'),
        body: jsonEncode(
          {
            'email': email,
            'password': password,
            'firstName': firstName,
            'lastName': lastName,
          },
        ));

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
