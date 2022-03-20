import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_placeholder_retrofit/model/post.dart';

import '../retrofit/api_client.dart';

class SinglePostPage extends StatelessWidget {
  final int postId;

  const SinglePostPage({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Post'),
      ),
      body: FutureBuilder<Post>(
        future: client.getPost(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            final post = snapshot.data!;
            return _buildPost(post);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Padding _buildPost(Post post) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            post.title!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(post.body!),
        ],
      ),
    );
  }
}
