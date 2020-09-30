import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:iwish_app/UIPages/constants_utils.dart';
import 'package:iwish_app/UIPages/event_widget.dart';
import 'package:iwish_app/UIPages/story_card.dart';
import 'package:iwish_app/UIPages/story_detail.dart';
import 'package:iwish_app/app/event_details_page.dart';
import 'package:iwish_app/app/event_page_back.dart';
import 'package:iwish_app/jobs/new_event.dart';


class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        //backgroundColor: Colors.transparent,
        title: const Text('Local Events'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
                Icons.add_photo_alternate, size: 40, color: Colors.white),
            onPressed: () =>
                NewEventPage.show(
                    context), //() => NewDonationPage.show(context),
          ),
        ],
      ),
      body: EventBody(),
    );
  }
}


  class EventBody extends StatefulWidget {
  @override
  _EventBodyState createState() => _EventBodyState();
  }

  class _EventBodyState extends State<EventBody> {


    final Firestore db = Firestore.instance;
    Stream slides;


    @override
    void initState() {
      _queryDb();
    }


    @override
    Widget build(BuildContext context) {
      return SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            SizedBox(height: kDefaultPadding /3),
            Expanded(
              child: Stack(
                children: <Widget>[
                  // Our background
                  Container(
                    margin: EdgeInsets.only(top: 70),
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: slides,
                    builder: (context, AsyncSnapshot snapshot) {
                      List slideList = snapshot.data.toList();
                      return ListView.builder(
                        // here we use our demo procuts list
                        itemCount: slideList.length,
                        itemBuilder: (context, index) =>
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 200,
                                child:EFeedCard(
                                  //imagePath, name, title, location, description
                                  eventImageUrl: slideList[index]['eventImageUrl'],
                                  name: slideList[index]['name'],
                                  title: slideList[index]['title'],
                                  city: slideList[index]['city'],
                                  story: slideList[index]['story'],
                                  attendees: slideList[index]['attendees'],
                                  date: slideList[index]['date'],
                                  duration: slideList[index]['duration'],
                                  index: index,
                                ),
                              ),
                            ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Stream _queryDb() {

      // Make a Query
      Query query = db.collectionGroup('events');
      // Map the documents to the data payload
      slides = query.snapshots().map((list) => list.documents.map((doc) => doc.data));
    }

  }
/*
  Stack(
        children: <Widget>[
          EventPageBackground(
            screenHeight: MediaQuery.of(context).size.height,
          ),
          StreamBuilder(
                      stream: slides,
                      builder: (context, AsyncSnapshot snapshot) {
                        List slideList = snapshot.data.toList();
                        return ListView.builder(
                          // here we use our demo procuts list
                          itemCount: slideList.length,
                          itemBuilder: (context, index) =>
                              Container(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EventDetailsPage(
                                          //imagePath, name, title, location, description
                                          imagePath: slideList[index]['eventImageUrl'],
                                          name: slideList[index]['name'],
                                          title: slideList[index]['title'],
                                          location: slideList[index]['city'],
                                          description: slideList[index]['story'],
                                          attendees: slideList[index]['attendees'],
                                          date: slideList[index]['date'],
                                          duration: slideList[index]['duration'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: EventWidget(
                                    //imagePath, name, title, location, description
                                    imagePath: slideList[index]['eventImageUrl'],
                                    name: slideList[index]['name'],
                                    title: slideList[index]['title'],
                                    location: slideList[index]['city'],
                                    description: slideList[index]['story'],
                                    attendees: slideList[index]['attendees'],
                                    date: slideList[index]['date'],
                                    duration: slideList[index]['duration'],
                                    index: index,
                                  ),
                                ),
                              ),
                        );
                      },
                    ),
      ],
    ),
   */


class EFeedCard extends StatefulWidget {
  final String id;
  final String name;
  final String title;
  final String city;
  final String story;
  final String eventImageUrl;
  final int attendees;
  final int duration;
  final String date;
  final int index;

  //Importing datas from json via explore_page.dart
  EFeedCard({
    this.eventImageUrl,
    this.name,
    this.title,
    this.city,
    this.story,
    this.index,
    this.attendees,
    this.date,
    this.duration,
    this.id
  });

  @override
  _EFeedCardState createState() => _EFeedCardState();
}

class _EFeedCardState extends State<EFeedCard> {



  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      // color: Colors.blueAccent,
      height: 160,
      child: InkWell(
        onTap: () {
          // Creates Details Page for respective Data.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  EventDetailsPage(
                    //imagePath, name, title, location, description
                    imagePath: widget.eventImageUrl,
                    name: widget.name,
                    title: widget.title,
                    location: widget.city,
                    description: widget.story,
                    attendees: widget.attendees,
                    date: widget.date,
                    duration: widget.duration,
                  ),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: widget.index.isEven ? kBlueColor : kSecondaryColor,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // our product image
            Positioned(
              top: 0,
              right: 0,
              child: Hero(
                tag: '${widget.title}',
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  height: 160,
                  // image is square but we add extra 20 + 20 padding thats why width is 200
                  width: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(image: NetworkImage(
                      widget.eventImageUrl,

                    ),
                      fit: BoxFit.cover,),
                  ),
                ),
              ),
            ),
            // Product title and price
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 136,
                // our image take 200 width, thats why we set out total width - 200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        widget.title,
                        style: Theme
                            .of(context)
                            .textTheme
                            .title
                            .apply(color: Color(0xFF1b1e44)),
                      ),
                    ),
                    Spacer(),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text('Date:'),
                          SizedBox(width: 10,),
                          Text(
                            widget.date, // + widget.likes.toString(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .button,
                          ),
                        ],
                      ),
                    ),
                    // it use the available space
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5, // 30 padding
                        vertical: kDefaultPadding / 4, // 5 top and bottom
                      ),
                      decoration: BoxDecoration(
                        color: widget.index.isEven
                            ? kSecondaryColor
                            : kBlueColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        widget.duration.toString() + ' hr', // + widget.likes.toString(),
                        style: Theme
                            .of(context)
                            .textTheme
                            .button,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}