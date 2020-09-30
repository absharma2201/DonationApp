
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class Enquiry {
  const Enquiry(
      {@required this.id, @required this.name, this.createdAt,
        this.date, this.title, this.reply, this.description,this.imageurl,
      });

  final String id;
  final String description;
  final String name;
  final String title;
  final String reply;
  final int createdAt;
  final String date;
  final String imageurl;


  factory Enquiry.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String title =  data['title'];
    final String description =  data['description'];
    final String name = data['name'];
    final String reply =  data['reply'];
    final int createdAt = data['createdAt'];
    final String date =  data['date'];
    final String imageurl =  data['imageurl'];
    return Enquiry(id: documentId, name: name, title: title, reply: reply,
        description: description,  imageurl: imageurl,
        createdAt: createdAt, date: date,);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'name': name,
      'reply': reply,
      'createdAt': createdAt,
      'date': date,
      'description': description,

      'imageurl': imageurl,

    };
  }

  @override
  int get hashCode => hashValues(id, name, reply, createdAt, title, imageurl, description);

  /*
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Enquiry otherEnquiry = other;
    return id == otherEnquiry.id &&
        name == otherEnquiry.name &&
        title == otherEnquiry.title &&
        createdAt == otherEnquiry.createdAt &&
        date == otherEnquiry.date;
  }
*/
  @override
  String toString() => 'id: $id, name: $name, reply: $reply'
      'title: $title, description: $description, imageurl: $imageurl, createdAt: $createdAt, date: $date';
}