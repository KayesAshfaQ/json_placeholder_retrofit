import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';
/*
@JsonSerializable()
class PostResponse {
  List<Post>? posts;

  PostResponse({this.posts});

  factory PostResponse.fromJson(Map<String, dynamic> json) =>
      _$PostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseToJson(this);
}*/

@JsonSerializable()
class Post {
  int? userId;
  int? id;
  String? title;
  String? body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
