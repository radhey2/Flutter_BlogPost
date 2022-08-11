import 'package:blogpost/sign_up.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BlogPost());
}

class BlogPost extends StatelessWidget {
  const BlogPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BlogPost',
      home: SignUpPage(),
    );
  }
}
