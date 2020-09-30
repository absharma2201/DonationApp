
import 'dart:ui';

import 'package:meta/meta.dart';

@immutable
class Event {
  const Event(
      {@required this.id, @required this.name, @required this.title, this.city,
        this.story, this.eventImageUrl, this.attendees, this.date, this.duration,
      });
  final String id;
  final String name;
  final String title;
  final String city;
  final String story;
  final String eventImageUrl;
  final int attendees;
  final int duration;
  final String date;



  factory Event.fromMap(Map<String, dynamic> data, String documentId) {
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
    final String eventImageUrl = data['eventImageUrl'];
    final int attendees = data['attendees'];
    final int duration = data['duration'];
    final String date = data['date'];
    return Event(id: documentId, date: date, duration: duration, name: name, attendees: attendees, title: title,
        city: city, story: story, eventImageUrl: eventImageUrl);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'city': city,
      'story': story,
      'eventImageUrl': eventImageUrl,
      'attendees': attendees,
      'date': date,
      'duration': duration,
    };
  }

  @override
  int get hashCode => hashValues(id, name, title, city, story, eventImageUrl);
/*
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Event otherEvent = other;
    return id == otherEvent.id &&
        name == otherEvent.name &&
        title == otherEvent.title &&
        city == otherEvent.city;
  }

 */

  @override
  String toString() => 'id: $id, duration: $duration, date: $date, name: $name, attendees: $attendees, title: $title, city: $city, story: $story, eventImage: $eventImageUrl';
}