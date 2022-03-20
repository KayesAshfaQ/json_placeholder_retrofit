import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_placeholder_retrofit/model/post.dart';
import 'package:json_placeholder_retrofit/pages/single_post_page.dart';

import '../retrofit/api_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('< Retrofit >'),
        centerTitle: true,
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final res = await client.postPost(
            Post(title: 'This is a title', body: 'This is a body'),
          );

          print(res.response);
        },
      ),
    );
  }

  FutureBuilder<List<Post>> _buildBody(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: client.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          final List<Post>? posts = snapshot.data;

          print(snapshot.connectionState.name);
          if (posts != null) {
            print(posts.length);
            return _buildPosts(context, posts);
          } else {
            return const Center(
              child: Text('no data found'),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildPosts(BuildContext context, List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              posts[index].title!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index].body!),
            onTap: () => _navigateToPost(context, posts[index].id!),
          ),
        );
      },
    );
  }

  void _navigateToPost(BuildContext context, int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SinglePostPage(postId: id),
      ),
    );
  }
}
