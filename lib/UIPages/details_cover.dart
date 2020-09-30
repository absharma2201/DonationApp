import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsCover extends StatelessWidget {
  //Variables to recieve datas from MainCard (as per index)
  //imagePath, name, title, location, description
  final String imagePath;
  final String name;
  final String title;
  final String location;

  //Recieving Datas
  DetailsCover({
    this.imagePath,
    this.name,
    this.title,
    this.location,
  });

  final Firestore locationsFSI = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: title + 'MainCard',
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 35),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          image: DecorationImage(
            image: NetworkImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.multiply,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Material(
              //Venue Name
              color: Colors.transparent,
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(height: 5),
            //              color: Colors.transparent,
            Material(
              //Venue Name
              color: Colors.transparent,
              child: Text(
                name,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            Material(
              //Venue Name
              color: Colors.transparent,
              child: Text(
                location,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),

            SizedBox(height: (MediaQuery.of(context).size.height / 3)),
          ],
        ),
      ),
    );
  }
}





//Details Info

class DetailsInfo extends StatelessWidget {
  final String description;

  DetailsInfo({
    this.description,
  });

  final Firestore locationsFSI = Firestore.instance;

  //This Page shows Stiories of a specific Location from FireStore.
  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        SizedBox(
          height: 100,
        ),
        Container(
          child: Text(
            //Description of the venue, fetched from json.
            description,
            textAlign: TextAlign.left,
            maxLines: 7,
            style: TextStyle(
              fontSize: 17,
              height: 1.2,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }
}