import 'package:flutter/material.dart';

import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: Center(
          child: Column(children: [
        const Padding(padding: EdgeInsets.all(20.0)),
        const Text(
          'Sign up',
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
                border: OutlineInputBorder(), label: Text('FirstName')),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        const SizedBox(
          width: 300,
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), label: Text('LastName')),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        const SizedBox(
          width: 300,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Email'),
              hintText: 'abcd@gmail.com',
            ),
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
        const SizedBox(
          width: 300,
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(), label: Text('Phone')),
          ),
        ),
        const SizedBox(
          height: 20.0,
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
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }),
          child: const Text('Sign up'),
        ),
        const SizedBox(
          height: 20.0,
        ),
      ])),
    );
  }
}
