import 'package:api_handler/api_handler.dart';

import 'model/post.dart';

class PostServices {
  final apiHandler = ApiHandler('https://jsonplaceholder.typicode.com/');

  Future<List<Post>> getPosts() async {
    final response = await apiHandler.requestWith(path: 'posts');

    if (response.isSuccess) {
      var postList = response.responseJSON as List;
      return postList.map((postJson) => Post.fromJson(postJson)).toList();
    } else {
      throw "Can't get posts.";
    }
  }
}
