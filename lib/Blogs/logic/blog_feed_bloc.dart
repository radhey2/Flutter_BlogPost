import '../../observable.dart';
import '../datasource/blog_repository.dart';
import '../datasource/modal.dart';

class BlogFeedBloc {
  late final Observable<List<Blog>> blogs;
  late final Observable<bool> isLoading;

  BlogFeedBloc() {
    blogs = Observable.seeded(<Blog>[]);
    isLoading = Observable.seeded(false);
    BlogRepository().fetchAllBlogs().listen((event) {
      blogs.addValue(event);
    });
  }

  Future<void> deleteBlog(int id) async {
    await BlogRepository().deleteBlog(id);
  }

  void dispose() {
    blogs.dispose();
    isLoading.dispose();
  }
}
