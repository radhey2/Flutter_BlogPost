import 'package:blogpost/Blogs/screens/feed_page.dart';
import 'package:blogpost/Auth/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../../common_widget.dart';
import '../logic/sign_in_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  late final SignInBloc bloc;

  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    bloc = SignInBloc();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
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
            child: StreamBuilder<String?>(
                stream: bloc.email.obs$,
                builder: (context, snapshot) {
                  return TextFormField(
                    onChanged: bloc.email.addValue,
                    decoration: InputDecoration(
                        errorText: snapshot.error as String?,
                        prefixIcon: const Icon(Icons.email),
                        border: const OutlineInputBorder(),
                        label: const Text('UserName')),
                  );
                }),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const VerticalSpacing(),
          SizedBox(
            width: 300,
            child: StreamBuilder(
                stream: bloc.password.obs$,
                builder: (context, snapshot) {
                  return StreamBuilder<bool>(
                      stream: bloc.passwordObscure.obs$,
                      initialData: true,
                      builder: (context, obscureSnap) {
                        return TextFormField(
                          onChanged: bloc.password.addValue,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            border: const OutlineInputBorder(),
                            label: const Text('Password'),
                            suffixIcon: InkWell(
                              child: !obscureSnap.data!
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              onTap: () {
                                bloc.passwordObscure
                                    .addValue(!obscureSnap.data!);
                              },
                            ),
                            errorText: snapshot.error as String?,
                          ),
                        );
                      });
                }),
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
          StreamBuilder<bool>(
              stream: bloc.validInputObs$,
              builder: (context, snapshot) {
                final isValid = snapshot.data ?? false;
                return ElevatedButton(
                  onPressed: isValid
                      ? () async {
                          if (await bloc.signIn()) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const FeedPage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('User not found')),
                            );
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).cardColor),
                    borderRadius: BorderRadius.circular(8.0),
                  )),
                  child: const Text(
                    'Login',
                  ),
                );
              }),
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
