import 'package:flutter/material.dart';

class CreateBlog extends StatelessWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Blog'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 80.0),
            child: Icon(Icons.upload_file),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(children: [
            const SizedBox(
              width: 400,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Write Your Blog')),
              ),
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Author Name'),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Title'),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextButton(onPressed: (() {}), child: const Text('submit')),
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.1,
              child: const Icon(Icons.add_a_photo),
            )
          ]),
        ),
      ),
    );
  }
}
