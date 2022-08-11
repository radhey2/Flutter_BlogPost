import 'package:blogpost/create_blog.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Feed'),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          color: Colors.blueGrey,
          child: Stack(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 64.0),
                  margin: const EdgeInsets.symmetric(horizontal: 256.0),
                  child: SizedBox(
                    child: Column(
                      children: const [
                        Expanded(
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              decoration: TextDecoration.underline,
                              decorationThickness: 0.5,
                            ),
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.topRight,
                        //   child: Image.asset('assets/images/Concept.jpg'),
                        // )
                      ],
                    ),
                  )),
              FloatingActionButton(onPressed: (() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateBlog()),
                );
              }))
            ],
          )),
    );
  }
}
