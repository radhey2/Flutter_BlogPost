import 'dart:async';
import 'package:blogpost/Blogs/logic/validators.dart';
import 'package:rxdart/rxdart.dart';

import '../../Auth/datasource/auth_repo.dart';

import '../../observable.dart';
import '../datasource/blog_repository.dart';
import '../datasource/modal.dart';

class AddBlogBloc with Validators {
  late final Observable<String?> title;
  late final Observable<String?> imgUrl;
  late final Observable<String?> content;

  late final Observable<bool> isLoading;

  AddBlogBloc() {
    title = Observable(validator: titleValidator);
    imgUrl = Observable(validator: imgUrlValidator);
    content = Observable(validator: contentValidator);

    isLoading = Observable.seeded(false);
  }

  Stream<bool> get validInputObs$ => Rx.combineLatest(
      [title.obs$, imgUrl.obs$, content.obs$], (values) => true);

  Future<void> addBlog() async {
    await BlogRepository().addBlog(Blog(
      title: title.value!,
      content: content.value!,
      imageUrl: imgUrl.value!,
      author: Author(email: AuthRepository().currentUser!.email, photoUrl: ""),
      updatedAt: DateTime.now(),
    ));
  }

  void dispose() {
    title.dispose();
    imgUrl.dispose();
    content.dispose();
  }
}
