import 'package:blogpost/Auth/auth_repo.dart';
import 'package:blogpost/feed_page.dart';
import 'package:blogpost/sign_up.dart';
import 'package:blogpost/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'common_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final AuthRepository authRepository = AuthRepository();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  bool _showPassword = false;

  Future<void> login() async {
    if (await authRepository.signIn(
        email: emailController.text, password: passController.text)) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const FeedPage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('User not found')));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 235, 127, 127),
        title: const Text('Create New Blog'),
      ),
      body: Center(
          child: Form(
        key: formKey,
        child: Column(children: [
          const Padding(padding: EdgeInsets.all(25.0)),
          const Text(
            'Sign in',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const VerticalSpacing(),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: emailController,
              validator: (value) {
                return value.validateAsEmail();
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('UserName')),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const VerticalSpacing(),
          SizedBox(
            width: 300,
            child: TextFormField(
              obscureText: !_showPassword,
              controller: passController,
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
              ),
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
              side: BorderSide(color: Theme.of(context).cardColor),
              borderRadius: BorderRadius.circular(8.0),
            )),
            onPressed: (() {
              login();
            }),
            child: const Text(
              'Login',
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 550.0),
            child: Row(
              children: [
                const Text("Does not Have Account?"),
                RawMaterialButton(
                    splashColor: Colors.cyanAccent,
                    shape: const StadiumBorder(),
                    onPressed: (() {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    }),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                          color: Colors.cyan, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          SignInButtonBuilder(
            text: 'Sign in with Email',
            icon: Icons.email,
            onPressed: () {},
            backgroundColor: Colors.blueGrey[700]!,
          ),
          const SizedBox(height: 10),
          SignInButton(
            Buttons.Google,
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SignInButton(
                Buttons.GitHub,
                mini: true,
                onPressed: () {},
              ),
              SignInButton(
                Buttons.Twitter,
                mini: true,
                onPressed: () {},
              ),
              SignInButton(
                Buttons.Facebook,
                mini: true,
                onPressed: () {},
              ),
              SignInButton(
                Buttons.LinkedIn,
                mini: true,
                onPressed: () {},
              ),
            ],
          )
        ]),
      )),
    );
  }
}
