import 'dart:convert';
import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:tutorial_flutter/model/Post.dart';
import 'package:http/http.dart' as http;

class NetworkRequest {
  static const String url = 'https://jsonplaceholder.typicode.com/posts';

  static List<Post> parsePost(String responseBody) {
    var list = jsonDecode(responseBody) as List<dynamic>;
    List<Post> post = list.map((e) => Post.fromJson(e)).toList();
    return post;
  }

  static Future<List<Post>> fetchPost({int page = 1}) async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return compute(parsePost, response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Not Found');
    } else {
      throw Exception('Cant get post');
    }
  }
}
