import 'package:flutter/material.dart';

import 'Auth/auth_repo.dart';
import 'Blogs/blog_repository.dart';
import 'Blogs/modal.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  final BlogRepository repo = BlogRepository();

  final AuthRepository _authRepo = AuthRepository();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();

  final TextEditingController _imageController = TextEditingController();

  bool _isLoading = false;

  Future<void> addBlog() async {
    if (_titleController.text.length >= 10) {
      final blog = Blog(
        title: _titleController.text,
        content: _contentController.text,
        imageUrl: _imageController.text,
        author: Author(email: _authRepo.currentUser!.email, photoUrl: ""),
        updatedAt: DateTime.now(),
      );

      setState(() {
        _isLoading = true;
      });
      _titleController.clear();
      _contentController.clear();
      _imageController.clear();
      await repo.addBlog(blog);
      setState(() {
        _isLoading = false;
      });
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 235, 127, 127),
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
            SizedBox(
              width: 400,
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Write Your Blog')),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _imageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Image url'),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Title'),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: _isLoading ? null : addBlog,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : const Text('Add Blog')),
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width * 0.1,
                child: const Icon(Icons.add_a_photo),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
