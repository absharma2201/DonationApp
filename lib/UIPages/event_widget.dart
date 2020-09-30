import 'package:flutter/material.dart';
import 'package:iwish_app/UIPages/constants_utils.dart';


class EventWidget extends StatefulWidget {
  final String imagePath;
  final String name;
  final String title;
  final String location;
  final String description;
  final int index;
  final int attendees;
  final int duration;
  final String date;


  //Importing datas from json via explore_page.dart
  EventWidget({
    this.imagePath,
    this.name,
    this.title,
    this.location,
    this.description,
    this.index,
    this.attendees,
    this.date,
    this.duration,
  });


  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20),
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              child: Image(
                image: NetworkImage(
                    widget.imagePath,
                ),
                height: 150,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: guestTextStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.timelapse),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.duration.toString() +'Hr',//widget.duration.toUpperCase(),
                          textAlign: TextAlign.right,
                          style: eventLocationTextStyle,
                        ),
                        Spacer(),
                        Text(
                          'Date: ' + widget.date ,//widget.duration.toUpperCase(),
                          textAlign: TextAlign.right,
                          style: eventLocationTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}