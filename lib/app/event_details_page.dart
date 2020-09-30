import 'package:flutter/material.dart';
import 'package:iwish_app/UIPages/constants_utils.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';


class EventDetailsPage extends StatefulWidget {

  //imagePath, name, title, location, description
  final String imagePath;
  final String name;
  final String location;
  final String description;
  final String title;
  final int attendees;
  final int duration;
  final String date;
  // final List<dynamic> storyList;

  //Recieving Datas
  EventDetailsPage({
    this.imagePath,
    this.name,
    this.title,
    this.description,
    this.location,
    this.attendees,
    this.duration,
    this.date,
  });
  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          EventDetailsBackground(imagePath: widget.imagePath),
          EventDetailsContent(
            //imagePath: widget.imagePath,
            name: widget.name,
            title: widget.title,
            description: widget.description,
            location: widget.location,
            date: widget.date,
            duration: widget.duration,
          ),
        ],
      ),
    );
  }
}


class EventDetailsBackground extends StatefulWidget {

  //imagePath, name, title, location, description
  final String imagePath;

  //Recieving Datas
  EventDetailsBackground({
    this.imagePath,
  });


  @override
  _EventDetailsBackgroundState createState() => _EventDetailsBackgroundState();
}

class _EventDetailsBackgroundState extends State<EventDetailsBackground> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.topCenter,
      child: ClipPath(
        clipper: ImageClipper(),
        child: Image(
          image: NetworkImage(
            widget.imagePath,),
          fit: BoxFit.cover,
          width: screenWidth,
          color: Color(0x99000000),
          colorBlendMode: BlendMode.darken,
          height: screenHeight * 0.5,
        ),
      ),

    );
  }
}

class ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset curveStartingPoint = Offset(0,40);
    Offset curveEndPoint = Offset(size.width, size.height * 0.95);
    path.lineTo(curveStartingPoint.dx, curveStartingPoint.dy - 5);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.85, curveEndPoint.dx - 60, curveEndPoint.dy + 10);
    path.quadraticBezierTo(size.width * 0.99, size.height * 0.99, curveEndPoint.dx, curveEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}




class EventDetailsContent extends StatefulWidget {
  //imagePath, name, title, location, description
  final String imagePath;
  final String name;
  final String location;
  final String description;
  final String title;
  final int attendees;
  final int duration;
  final String date;
  // final List<dynamic> storyList;

  //Recieving Datas
  EventDetailsContent({
    this.imagePath,
    this.name,
    this.title,
    this.description,
    this.location,
    this.attendees,
    this.duration,
    this.date,
  });


  @override
  _EventDetailsContentState createState() => _EventDetailsContentState();
}

class _EventDetailsContentState extends State<EventDetailsContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
            child: Text(
              widget.title,
              style: eventWhiteTitleTextStyle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.24),
            child: FittedBox(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.location + ', ' + widget.date,
                    style: eventLocationTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: <Widget>[
                Text(
                  "GUESTS:",
                  style: eventLocationTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                ),
                Text(
                  '101',//widget.attendees.toString(),
                  style: eventLocationTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                ),
                Spacer(),
                Container(
                  // alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(Icons.share),
                    iconSize: 40.0,
                    color: Colors.white,
                    onPressed: () => Share.share("${widget.title} - ${widget.date}"),
                    //=> Share.share(
                    //  "Click the link to read the article $myUrl"),
                  ),
                ),
              ],
            ),
          ),

          if (widget.description.isNotEmpty) Padding(
            padding: const EdgeInsets.all(16),
            child: Text(widget.description, style: eventLocationTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.w700),),
          ),

        ],
      ),
    );
  }
}