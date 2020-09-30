
import 'dart:ui';

import 'package:meta/meta.dart';

@immutable
class Post {
  const Post(
      {@required this.id, @required this.name, @required this.title, this.city,
        this.story, this.postImageUrl, this.likes,
      });
  final String id;
  final String name;
  final String title;
  final String city;
  final String story;
  final String postImageUrl;
  final int likes;



  factory Post.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    if (name == null) {
      return null;
    }
    final String title = data['title'];
    final String city = data['city'];
    final String story = data['story'];
    final String postImageUrl = data['postImageUrl'];
    final int likes = data['likes'];
    return Post(id: documentId, name: name, likes: likes, title: title, city: city, story: story, postImageUrl: postImageUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'city': city,
      'story': story,
      'postImageUrl': postImageUrl,
      'likes': likes,
    };
  }

  @override
  int get hashCode => hashValues(id, name, title, city, story, postImageUrl);

  /*
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Post otherPost = other;
    return id == otherPost.id &&
        name == otherPost.name &&
        title == otherPost.title &&
        city == otherPost.city;
  }

   */

  @override
  String toString() => 'id: $id, name: $name, likes: $likes, title: $title, city: $city, story: $story, postImage: $postImageUrl';
}