import 'package:blogpost/Auth/screens/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BlogPost());
}

class BlogPost extends StatelessWidget {
  const BlogPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(44, 205, 61, 61)),
      debugShowCheckedModeBanner: false,
      title: 'BlogPost',
      home: const LoginPage(),
    );
  }
}
