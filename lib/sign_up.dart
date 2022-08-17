import 'package:blogpost/Auth/auth_repo.dart';
import 'package:blogpost/common_widget.dart';
import 'package:blogpost/feed_page.dart';
import 'package:blogpost/login_page.dart';
import 'package:blogpost/validators.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthRepository repo = AuthRepository();
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  bool _showPassword = false;

  Future<void> signUp() async {
    final isSuccess = await repo.signUp(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    if (mounted) {
      if (isSuccess) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Some error occured!")));
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
        backgroundColor: const Color.fromARGB(255, 235, 127, 127),
      ),
      body: Center(
          child: Form(
        key: formKey,
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
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('FirstName')),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('LastName')),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: emailController,
              validator: (value) {
                return value.validateAsEmail();
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Email'),
                hintText: 'abcd@gmail.com',
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: passwordController,
              validator: (value) {
                return value.validateAsPassword();
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: const Text('Password'),
                suffixIcon: InkWell(
                  child: _showPassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onTap: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
                hintText:
                    'Must have at least one uppercase letter, one lowercase letter and one number',
              ),
            ),
          ),
          const VerticalSpacing(),
          ElevatedButton.icon(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                signUp();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please check the inputs')));
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
            ),
            icon: const Icon(Icons.login),
            label: const Text('Sign Up'),
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FeedPage()),
              );
            }),
            child: const Text('Sign up'),
          ),
          const SizedBox(
            height: 20.0,
          ),
        ]),
      )),
    );
  }
}
