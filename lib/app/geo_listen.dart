import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iwish_app/CloudDatabase/databaseService.dart';
import 'package:iwish_app/Models/requests.dart';
import 'package:iwish_app/jobs/list_items_builder.dart';
import 'package:iwish_app/jobs/request_list_tile.dart';
import 'package:latlong/latlong.dart';
import 'dart:async';
import 'package:intl/intl.dart';


import 'package:provider/provider.dart';




import 'dart:ui';

import 'package:meta/meta.dart';


class GeoListenPage extends StatefulWidget {
  @override
  _GeoListenPageState createState() => _GeoListenPageState();
}

class _GeoListenPageState extends State<GeoListenPage> with SingleTickerProviderStateMixin {
  Geolocator geolocator = Geolocator();
  GeoPoint geo;
  Position userLocation;
  final Firestore db = Firestore.instance;
  Stream slides1;
  Stream slides5;

  Stream slides10;

  Stream slides20;

  TabController _controller;
  double radius;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation().then((position) {
      userLocation = position;
    });
    _queryDb1();
    _queryDb5();
    _queryDb10();
    _queryDb20();

    radius = 1.0;
    _controller = new TabController(length: 4, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    _getLocation().then((value) {
                      setState(() {
                        userLocation = value;
                      });
                    });
                  },
                  color: Colors.blue,
                  child: Text(
                    "Set Your Location",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              userLocation == null
                  ? CircularProgressIndicator() :
              Container(
                height: 0.9 * MediaQuery.of(context).size.height,
                child:
                //_buildContents(context, userLocation, 2),
                Column(
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
                      child: new TabBar(
                        controller: _controller,
                        tabs: [
                          new Tab(
                            //icon: const Icon(FontAwesomeIcons.newspaper),
                            text: '1km',
                          ),
                          new Tab(
                            //icon: const Icon(FontAwesomeIcons.newspaper),
                            text: '5km',
                          ),

                          new Tab(
                            //icon: const Icon(FontAwesomeIcons.calendarCheck),
                            text: '10km',
                          ),
                          new Tab(
                            //icon: const Icon(FontAwesomeIcons.newspaper),
                            text: '20km',
                          ),
                        ],
                      ),
                    ),
                    new Container(
                      height: MediaQuery.of(context).size.height*0.6,
                      color: Colors.transparent,
                      child: new TabBarView(
                        controller: _controller,
                        children: <Widget>[
                          _buildContents1(context, userLocation, radius),
                          _buildContents5(context, userLocation, radius*5),
                          _buildContents10(context, userLocation, radius*10),
                          _buildContents20(context, userLocation, radius*20),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
              //_buildContents(context, userLocation, 2),// _build_list(context, userLocation, 2),
                /*
              Text("Location:" +
                  userLocation.latitude.toString() +
                  " " +
                  userLocation.longitude.toString()),
              */

            ],
          ),
        ),
      ),
    );
  }



  Widget _buildContents1(BuildContext context,  Position pos, double radius) {
    _getLocation().then((value) {
      setState(() {
        userLocation = value;
      });
    });
    return StreamBuilder(
      stream: slides1,
      builder: (context, AsyncSnapshot snapshot) {
        List slideList = snapshot.data.toList();
       // print(slideList.length);

        return ListView.builder(
          itemCount: slideList.length,
          itemBuilder: (context, index)  {
            final Distance distance = Distance();
           // double totalDistanceInM = 0;
            double totalDistanceInKm = 0;
            /*

              totalDistanceInM += distance(
                  LatLng(slideList[index]['geoloc'].latitude, slideList[index]['geoloc'].longitude),
                  LatLng(pos.latitude, pos.longitude)
              );
*/
              totalDistanceInKm += distance.as(
                LengthUnit.Kilometer,
                LatLng(slideList[index]['geoloc'].latitude, slideList[index]['geoloc'].longitude),
                LatLng(pos.latitude, pos.longitude),
              );
              /*
            print('Data in distance');

            print(totalDistanceInM);
              print(totalDistanceInKm);
              */

              if (totalDistanceInKm < radius && (slideList[index]['status'].compareTo('Approval Pending') == 0) ) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(width: 2.0, color: Color(0xff00c6ff),
                            ))),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        //image: new AssetImage('assets/'+ request.name +'.png'),
                        FontAwesomeIcons.hands,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    slideList[index]['description'],
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),

                  subtitle: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Row(
                            children: <Widget>[
                             // Icon(Icons.linear_scale, color: Color(0xff00c6ff),),
                              Text(slideList[index]['addr']
                                  //DateFormat.yMMMMd().format(DateTime.fromMicrosecondsSinceEpoch(slideList[index]['createdAt'])).toString()
                                  , style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  //trailing: Icon(Icons.chevron_right, color: Color(0xff00c6ff), size: 30.0),
//{},

                );
                return ListTile(
                  title: Text(slideList[index]['name'], style: TextStyle(color: Colors.black),),
                  subtitle: Text(slideList[index]['geoloc'].longitude.toString(), style: TextStyle(color: Colors.black)),
                );
              }
          }
        );
      },

    );
  }
  Widget _buildContents5(BuildContext context,  Position pos, double radius) {
    _getLocation().then((value) {
      setState(() {
        userLocation = value;
      });
    });
    return StreamBuilder(
      stream: slides5,
      builder: (context, AsyncSnapshot snapshot) {
        List slideList = snapshot.data.toList();
        // print(slideList.length);

        return ListView.builder(
            itemCount: slideList.length,
            itemBuilder: (context, index)  {
              final Distance distance = Distance();
              // double totalDistanceInM = 0;
              double totalDistanceInKm = 0;
              /*

              totalDistanceInM += distance(
                  LatLng(slideList[index]['geoloc'].latitude, slideList[index]['geoloc'].longitude),
                  LatLng(pos.latitude, pos.longitude)
              );
*/
              totalDistanceInKm += distance.as(
                LengthUnit.Kilometer,
                LatLng(slideList[index]['geoloc'].latitude, slideList[index]['geoloc'].longitude),
                LatLng(pos.latitude, pos.longitude),
              );
              /*
            print('Data in distance');

            print(totalDistanceInM);
              print(totalDistanceInKm);
              */

              if (totalDistanceInKm < radius && (slideList[index]['status'].compareTo('Approval Pending') == 0) ) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(width: 2.0, color: Color(0xff00c6ff),
                            ))),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        //image: new AssetImage('assets/'+ request.name +'.png'),
                        FontAwesomeIcons.hands,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    slideList[index]['description'],
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),

                  subtitle: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.linear_scale, color: Color(0xff00c6ff),),
                              Text(slideList[index]['addr']
                                  //DateFormat.yMMMMd().format(DateTime.fromMicrosecondsSinceEpoch(slideList[index]['createdAt'])).toString()
                                  , style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  //trailing: Icon(Icons.chevron_right, color: Color(0xff00c6ff), size: 30.0),
//{},

                );
                return ListTile(
                  title: Text(slideList[index]['name'], style: TextStyle(color: Colors.black),),
                  subtitle: Text(slideList[index]['geoloc'].longitude.toString(), style: TextStyle(color: Colors.black)),
                );
              }
            }
        );
      },

    );
  }
  Widget _buildContents10(BuildContext context,  Position pos, double radius) {
    _getLocation().then((value) {
      setState(() {
        userLocation = value;
      });
    });
    return StreamBuilder(
      stream: slides10,
      builder: (context, AsyncSnapshot snapshot) {
        List slideList = snapshot.data.toList();
        // print(slideList.length);

        return ListView.builder(
            itemCount: slideList.length,
            itemBuilder: (context, index)  {
              final Distance distance = Distance();
              // double totalDistanceInM = 0;
              double totalDistanceInKm = 0;
              /*

              totalDistanceInM += distance(
                  LatLng(slideList[index]['geoloc'].latitude, slideList[index]['geoloc'].longitude),
                  LatLng(pos.latitude, pos.longitude)
              );
*/
              totalDistanceInKm += distance.as(
                LengthUnit.Kilometer,
                LatLng(slideList[index]['geoloc'].latitude, slideList[index]['geoloc'].longitude),
                LatLng(pos.latitude, pos.longitude),
              );
              /*
            print('Data in distance');

            print(totalDistanceInM);
              print(totalDistanceInKm);
              */

              if (totalDistanceInKm < radius && (slideList[index]['status'].compareTo('Approval Pending') == 0) ) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(width: 2.0, color: Color(0xff00c6ff),
                            ))),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        //image: new AssetImage('assets/'+ request.name +'.png'),
                        FontAwesomeIcons.hands,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    slideList[index]['description'],
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),

                  subtitle: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.linear_scale, color: Color(0xff00c6ff),),
                              Text(slideList[index]['addr']
                                  //DateFormat.yMMMMd().format(DateTime.fromMicrosecondsSinceEpoch(slideList[index]['createdAt'])).toString()
                                  , style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  //trailing: Icon(Icons.chevron_right, color: Color(0xff00c6ff), size: 30.0),
//{},

                );
                return ListTile(
                  title: Text(slideList[index]['name'], style: TextStyle(color: Colors.black),),
                  subtitle: Text(slideList[index]['geoloc'].longitude.toString(), style: TextStyle(color: Colors.black)),
                );
              }
            }
        );
      },

    );
  }

  Widget _buildContents20(BuildContext context,  Position pos, double radius) {
    _getLocation().then((value) {
      setState(() {
        userLocation = value;
      });
    });
    return StreamBuilder(
      stream: slides20,
      builder: (context, AsyncSnapshot snapshot) {
        List slideList = snapshot.data.toList();
        // print(slideList.length);

        return ListView.builder(
            itemCount: slideList.length,
            itemBuilder: (context, index)  {
              final Distance distance = Distance();
              // double totalDistanceInM = 0;
              double totalDistanceInKm = 0;
              /*

              totalDistanceInM += distance(
                  LatLng(slideList[index]['geoloc'].latitude, slideList[index]['geoloc'].longitude),
                  LatLng(pos.latitude, pos.longitude)
              );
*/
              totalDistanceInKm += distance.as(
                LengthUnit.Kilometer,
                LatLng(slideList[index]['geoloc'].latitude, slideList[index]['geoloc'].longitude),
                LatLng(pos.latitude, pos.longitude),
              );
              /*
            print('Data in distance');

            print(totalDistanceInM);
              print(totalDistanceInKm);
              */

              if (totalDistanceInKm < radius && (slideList[index]['status'].compareTo('Approval Pending') == 0) ) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 12.0),
                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(width: 2.0, color: Color(0xff00c6ff),
                            ))),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        //image: new AssetImage('assets/'+ request.name +'.png'),
                        FontAwesomeIcons.hands,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    slideList[index]['description'],
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),

                  subtitle: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.linear_scale, color: Color(0xff00c6ff),),
                              Text(slideList[index]['addr']
                                  //DateFormat.yMMMMd().format(DateTime.fromMicrosecondsSinceEpoch(slideList[index]['createdAt'])).toString()
                                  , style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  //trailing: Icon(Icons.chevron_right, color: Color(0xff00c6ff), size: 30.0),
//{},

                );
                return ListTile(
                  title: Text(slideList[index]['name'], style: TextStyle(color: Colors.black),),
                  subtitle: Text(slideList[index]['geoloc'].longitude.toString(), style: TextStyle(color: Colors.black)),
                );
              }
            }
        );
      },

    );
  }


/*
            Future<double> distanceInMeters = Geolocator().distanceBetween(pos.latitude, pos.longitude,
                slideList[index]['name'].latitude, slideList[index]['name'].longitude);
            print(distanceInMeters);
 */

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

       /*
              geo = new GeoPoint(currentLocation.latitude, currentLocation.longitude);
      _firestore.collection('geoLoc').add({'name': geo}).then((_) {
        print('added successfully');
      });
            db.collection("geoLoc")
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          //print('${f.data}}');
          GeoPoint pos = f.data['name'];
          //print(pos.latitude.toString() + " " + pos.longitude.toString());

        });
      });
*/

    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }



  Stream _queryDb1() {
    // Make a Query
    Query query = db.collectionGroup('requests').where("status", isEqualTo: "Approval Pending");

    // Map the documents to the data payload
    slides1 = query.snapshots().map((list) => list.documents.map((doc) => doc.data));
  }
  Stream _queryDb5() {
    // Make a Query
    Query query = db.collectionGroup('requests').where("status", isEqualTo: "Approval Pending");

    // Map the documents to the data payload
    slides5 = query.snapshots().map((list) => list.documents.map((doc) => doc.data));
  }
  Stream _queryDb10() {
    // Make a Query
    Query query = db.collectionGroup('requests').where("status", isEqualTo: "Approval Pending");

    // Map the documents to the data payload
    slides10 = query.snapshots().map((list) => list.documents.map((doc) => doc.data));
  }
  Stream _queryDb20() {
    // Make a Query
    Query query = db.collectionGroup('requests').where("status", isEqualTo: "Approval Pending");

    // Map the documents to the data payload
    slides20 = query.snapshots().map((list) => list.documents.map((doc) => doc.data));
  }


  void openBottomSheet(BuildContext context, Request request) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 500.0,//MediaQuery.of(context).size.height/2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child:
                      Text(
                        request.description,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                    Divider(),

                    Row(
                      children: <Widget>[
                        Text(
                          "Category : ",
                          style: Theme.of(context).textTheme.body2.apply(color: Colors.black),
                        ),
                        Expanded(
                          child: Text(
                            "${request.category == null ? 'All Category' : request.category.toString()}",
                            style: Theme.of(context).textTheme.subhead.apply(color: Colors.black),
                          ),
                        ),

                      ],
                    ),
                    Divider(),

                    Row(
                      children: <Widget>[
                        Text(
                          "Date: ",
                          style: Theme.of(context).textTheme.body2.apply(color: Colors.black),
                        ),
                        Expanded(
                          child: Text(
                            "${request.date == null ? '01/01/2020' : DateFormat.yMMMMd().format(DateTime.fromMicrosecondsSinceEpoch(request.createdAt)).toString()}",
                            style: Theme.of(context).textTheme.subhead.apply(color: Colors.black),
                          ),
                        ),

                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Text(
                          "Status : ",
                          style: Theme.of(context).textTheme.body2.apply(color: Colors.black),
                        ),
                        Expanded(
                          child: Text(
                            "${request.addr == null ? 'No Address' : request.status}",
                            style: Theme.of(context).textTheme.subhead.apply(color: Colors.black),
                          ),
                        ),

                      ],
                    ),

                    Divider(),


                  ],
                ),
              ),
            ),
          );
        });
  }

}