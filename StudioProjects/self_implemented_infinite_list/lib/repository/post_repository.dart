import 'dart:convert';

import '../models/post.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<Post>> fetchPosts(int start,int end) async {
    final response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=$end'));
    print('API called....');
    return List<Post>.from(json.decode(response.body).map((item) =>
            Post(id: item['id'], title: item['title'], body: item['body'])))
        .toList();
  }
}
