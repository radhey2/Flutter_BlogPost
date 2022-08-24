import 'package:blogpost/Auth/datasource/auth_repo.dart';
import 'package:blogpost/common_widget.dart';
import 'package:blogpost/Blogs/screens/feed_page.dart';
import 'package:blogpost/Auth/screens/login_page.dart';
import 'package:blogpost/Auth/logic/validators.dart';
import 'package:flutter/material.dart';

import '../logic/sign_up_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final SignUpBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = SignUpBloc();
  }

  Future<void> signUp() async {
    final isSuccess = await bloc.signUp();
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
    super.dispose();
    bloc.dispose();
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
            child: StreamBuilder<String?>(
                stream: bloc.firstName.obs$,
                builder: (context, snapshot) {
                  return TextFormField(
                    onChanged: bloc.firstName.addValue,
                    decoration: InputDecoration(
                        errorText: snapshot.error as String?,
                        prefixIcon: const Icon(Icons.face),
                        border: const OutlineInputBorder(),
                        label: const Text('FirstName')),
                  );
                }),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: 300,
            child: StreamBuilder<String?>(
                stream: bloc.lastName.obs$,
                builder: (context, snapshot) {
                  return TextFormField(
                    onChanged: bloc.lastName.addValue,
                    decoration: InputDecoration(
                        errorText: snapshot.error as String?,
                        prefixIcon: const Icon(Icons.face),
                        border: const OutlineInputBorder(),
                        label: const Text('LastName')),
                  );
                }),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: 300,
            child: StreamBuilder<String?>(
                stream: bloc.email.obs$,
                builder: (context, snapshot) {
                  return TextFormField(
                    onChanged: bloc.email.addValue,
                    decoration: InputDecoration(
                      errorText: snapshot.error as String?,
                      prefixIcon: const Icon(Icons.email_rounded),
                      border: const OutlineInputBorder(),
                      label: const Text('Email'),
                      hintText: 'abcd@gmail.com',
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: 300,
            child: StreamBuilder<String?>(
                stream: bloc.password.obs$,
                builder: (context, snapshot) {
                  return StreamBuilder<bool>(
                      stream: bloc.passwordObscure.obs$,
                      initialData: true,
                      builder: (context, obsecureSnap) {
                        return TextFormField(
                          onChanged: bloc.password.addValue,
                          decoration: InputDecoration(
                            errorText: snapshot.error as String?,
                            prefixIcon: const Icon(Icons.password_sharp),
                            border: const OutlineInputBorder(),
                            label: const Text('Password'),
                            suffixIcon: InkWell(
                              child: !obsecureSnap.data!
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              onTap: () {
                                bloc.passwordObscure
                                    .addValue(!obsecureSnap.data!);
                              },
                            ),
                            hintText:
                                'Must have at least one uppercase letter, one lowercase letter and one number',
                          ),
                        );
                      });
                }),
          ),
          const VerticalSpacing(),
          StreamBuilder<bool>(
              stream: bloc.validInputObs$,
              builder: (context, snapshot) {
                final isValid = snapshot.data ?? false;
                return ElevatedButton.icon(
                  onPressed: isValid ? signUp : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                  ),
                  icon: const Icon(Icons.login),
                  label: const Text('Sign Up'),
                );
              }),
        ]),
      )),
    );
  }
}
