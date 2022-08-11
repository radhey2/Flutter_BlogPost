import 'package:flutter/material.dart';

import 'feed_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Blog'),
      ),
      body: Center(
          child: Column(children: [
        const Padding(padding: EdgeInsets.all(55.0)),
        const Text(
          'Sign in',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        const SizedBox(
          width: 300,
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), label: Text('UserName')),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        const SizedBox(
          width: 300,
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), label: Text('Password')),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        const Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.cyan,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(8.0),
          )),
          onPressed: (() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FeedPage()),
            );
          }),
          child: const Text('Login'),
        ),
        const SizedBox(
          height: 20.0,
        ),
        RichText(
          text: const TextSpan(
            text: "does not have account?",
            children: <TextSpan>[
              TextSpan(
                  text: 'Sign up',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.cyan)),
            ],
          ),
        )
      ])),
    );
  }
}
