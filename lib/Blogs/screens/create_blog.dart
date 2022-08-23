import 'package:flutter/material.dart';

import '../logic/add_blog_bloc.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  late final AddBlogBloc bloc;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    bloc = AddBlogBloc();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 138, 109, 109),
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
              child: StreamedInputField(
                addValue: bloc.content.addValue,
                title: 'Content',
                stream: bloc.content.obs$,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: StreamedInputField(
                addValue: bloc.title.addValue,
                title: 'title',
                stream: bloc.title.obs$,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              child: StreamedInputField(
                addValue: bloc.imgUrl.addValue,
                title: 'Image Url',
                stream: bloc.imgUrl.obs$,
              ),
            ),
            const SizedBox(height: 30),
            StreamBuilder<bool>(
                stream: bloc.validInputObs$,
                builder: (context, snapshot) {
                  final isValid = snapshot.data ?? false;

                  return StreamBuilder<bool>(
                      stream: bloc.isLoading.obs$,
                      builder: (context, loadingSnapshot) {
                        final isLoading = loadingSnapshot.data ?? false;
                        return ElevatedButton(
                            onPressed: isLoading || !isValid
                                ? null
                                : () {
                                    bloc.isLoading.addValue(true);
                                    bloc.addBlog().then((_) {
                                      bloc.isLoading.addValue(false);
                                      if (mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    });
                                  },
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text('Add Blog'));
                      });
                }),
            InkWell(
              onTap: () {},
              child: SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width * 0.1,
                child: const Icon(Icons.add_a_photo),
              ),
            ),
          ]),
        )));
  }
}

class StreamedInputField<T> extends StatelessWidget {
  final Stream<T> stream;
  final void Function(String?) addValue;
  final String title;

  const StreamedInputField({
    Key? key,
    required this.stream,
    required this.addValue,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
        stream: stream,
        builder: (context, snapshot) {
          return TextField(
            onChanged: addValue,
            decoration: InputDecoration(
              hintText: title,
              labelText: title,
            ),
          );
        });
  }
}
