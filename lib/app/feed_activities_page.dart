import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iwish_app/UIPages/constants_utils.dart';
import 'package:iwish_app/UIPages/sliderDots.dart';

import 'package:iwish_app/UIPages/story_card.dart';

import 'package:iwish_app/app/events_page.dart';

import 'package:iwish_app/app/story_dashboard.dart';
import 'package:iwish_app/jobs/enquiry_page.dart';
import 'package:iwish_app/jobs/new_enquiry.dart';

import 'package:iwish_app/jobs/new_post_page.dart';

class feedActivityPage extends StatefulWidget {
  @override
  _feedActivityPageState createState() => new _feedActivityPageState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _feedActivityPageState extends State<feedActivityPage>
    with SingleTickerProviderStateMixin {
  double screenHeight, screenWidth;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
/*
            FeedPageBackground(
              screenHeight: MediaQuery.of(context).size.height,
            ),
 */
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Center(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.2,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.6),
                                  BlendMode.dstATop),
                              image: AssetImage(
                                'assets/image2.jpg',
                              ),
                            ),
                            border: Border.all(color: Colors.blueAccent),
                            //borderRadius: BorderRadius.circular(20),
                          )),
                      ListTile(
                          title:RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(text: 'I',
                                  style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 60,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                                TextSpan(text: ' wish',
                                  style: GoogleFonts.aladin(
                                    textStyle: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 60,
                                    ),
                                  ),

                                ), ],
                            ),
                          ),
                          subtitle: Text(
                            'No Wish Goes Unfulfilled.',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                          /*
                                RichText(
                                  text: TextSpan(
                                      text: 'One Mission: ',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                      children: <TextSpan>[
                                        TextSpan(text: 'No Child Without Education.',
                                            style: TextStyle(
                                                color: Color(0xff00c6ff), fontSize: 18),
                                            /*
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                // navigate to desired screen
                                              }

                                             */
                                        )
                                      ]
                                  ),
                                ),
                                */
                          ),
                    ],
                  ),
                )),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                /*
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
            */
                SafeArea(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: <Widget>[
                              new Container(
                                decoration: new BoxDecoration(
                                    color: Theme.of(context).primaryColor),
                                child: new TabBar(
                                  controller: _controller,
                                  tabs: [
                                    new Tab(
                                      icon: const Icon(
                                          FontAwesomeIcons.newspaper),
                                      text: 'Feeds',
                                    ),
                                    new Tab(
                                      icon: const Icon(
                                          FontAwesomeIcons.calendarCheck),
                                      text: 'Events',
                                    ),
                                  ],
                                ),
                              ),
                              new Container(
                                height: 0.5 * screenHeight,
                                color: Colors.transparent,
                                child: new TabBarView(
                                  controller: _controller,
                                  children: <Widget>[
                                    new Card(
                                      color: Theme.of(context).primaryColor,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text("Trending",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24.0,
                                                        fontFamily:
                                                            "Calibre-Semibold",
                                                        letterSpacing: 1.0,
                                                      )),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    22.0,
                                                                vertical: 6.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (_) {
                                                              return FeedsScreen();
                                                            }));
                                                          },
                                                          child: Text(
                                                              "View All",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 0.4 * screenHeight,
                                            child: FirestoreSlideshow(),
                                          ),
                                        ],
                                      ),

                                      /*
                                new ListTile(
                                  leading: const Icon(Icons.home),
                                  title: new TextField(
                                    decoration: const InputDecoration(hintText: 'Search for address...'),
                                  ),
                                ),
                                */
                                    ),
                                    new Card(
                                      color: Theme.of(context).primaryColor,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              "Upcoming Events",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 24.0,
                                                fontFamily:
                                                    "Calibre-Semibold",
                                                letterSpacing: 1.0,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Container(
                                                child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      InkWell(
                                                        onTap: ()  {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) {
                                                                    return EventsPage();
                                                                  }));
                                                        },
                                                        child: Container(
                                                          height: 200,
                                                          width: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              colorFilter:
                                                                  new ColorFilter
                                                                          .mode(
                                                                      Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.3),
                                                                      BlendMode
                                                                          .dstATop),
                                                              image: AssetImage(
                                                                'assets/image7.jpg',
                                                              ),
                                                            ),
                                                            //shape: BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  SizedBox(
                                                                    height: 30,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .calendar_today,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 30,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  Text(
                                                                    'Click to know whats happening around',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            24,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                          ),
                                          //MyCharts(title: 'iWish Statistics'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.blue,),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              child:  Column(
                                children: <Widget>[
                                  Text(
                                    "Our Vision",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headline.apply(color: Colors.white),
                                  ),
                                  Text(
                                    "A world where education is available to all , without the barriers of location or cost.",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.subhead.apply(color: Colors.white),
                                  ),
                                ],
                              )

                          ),
                        ),
                        Divider(),
                        Divider(color: Colors.blue,),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              child:  Column(
                                children: <Widget>[
                                  Text(
                                    "Follow Us",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headline.apply(color: Colors.white),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(FontAwesomeIcons.facebook, size: 40, color: Colors.white,),
                                        Spacer(),
                                        Icon(FontAwesomeIcons.instagram,  size: 40, color: Colors.white,),
                                        Spacer(),
                                        Icon(FontAwesomeIcons.twitter,  size: 40, color: Colors.white,),
                                      ],
                                    ),
                                  ),


                                ],
                              )

                          ),
                        ),
                        Divider(),
                        Divider(color: Colors.blue,),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              child:  Column(
                                children: <Widget>[
                                  Text(
                                    "Join Us",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headline.apply(color: Colors.white),
                                  ),
                                  Text(
                                    "We all should work jointly to fulfill the dreams of the underprivileged in our society. And this will help to make the future doctors, engineers, scientists, etc,. and support needy people. For successful implementation of this project your support is essential.",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.subhead.apply(color: Colors.white),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(

                                        child: RaisedButton(
                                          color: Colors.blueGrey,
                                          onPressed: (){
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                                  return NewEnquiryPage();
                                                }));
                                          },
                                          child: Text('Join Today',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.subhead.apply(color: Colors.white),
                                          ),

                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )

                          ),
                        ),
                        Divider(),
                        Divider(color: Colors.blue,),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                              child:  Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Spacer(),
                                      Icon(FontAwesomeIcons.handHoldingHeart, size: 40, color: Colors.white,),
                                      Spacer(),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(text: 'I',
                                              style: TextStyle(color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 60,
                                                fontFamily: 'Raleway',
                                              ),
                                            ),
                                            TextSpan(text: ' wish',
                                              style: GoogleFonts.aladin(
                                                textStyle: TextStyle(color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 60,
                                                ),
                                              ),

                                            ), ],
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(FontAwesomeIcons.hands, size: 40, color: Colors.white,),
                                      Spacer(),
                                    ],
                                  ),
                                  Text(
                                    "v 2.0.0",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.subhead.apply(color: Colors.white),
                                  ),
                                ],
                              )

                          ),
                        ),
                        Divider(),
                        Divider(),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FirestoreSlideshow extends StatefulWidget {
  createState() => FirestoreSlideshowState();
}

class FirestoreSlideshowState extends State<FirestoreSlideshow> {
  final PageController ctrl = PageController(
    viewportFraction: 0.7,
  );

  final Firestore db = Firestore.instance;
  Stream slides;

  // Keep track of current page to avoid unnecessary renders
  int currentPage = 1;

  @override
  void initState() {
    _queryDb();

    // Set state when page changes
    ctrl.addListener(() {
      int next = ctrl.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: slides,
        initialData: [],
        builder: (context, AsyncSnapshot snap) {
          // return //storyList(snapshot.data.documents);
          List slideList = snap.data.toList();
          return PageView.builder(
              controller: ctrl,
              itemCount: slideList.length + 1,
              itemBuilder: (context, int currentIdx) {
                if (currentIdx == 0) {
                  return _buildTagPage();
                } else if (slideList.length >= currentIdx) {
                  // Active page
                  bool active = currentIdx == currentPage;
                  return _buildStoryPage(
                      slideList[slideList.length - currentIdx], active);
                }
              });
        });
  }

  Stream _queryDb() {
    // Make a Query
    Query query = db.collectionGroup('posts');
    // Map the documents to the data payload
    slides =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));
  }

  // Builder Functions

  _buildStoryPage(Map data, bool active) {
    // Animated Properties
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 10 : 20;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 30, right: 30),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
/*
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(data['postImageUrl']),
            ),
*/
          boxShadow: [
            BoxShadow(
                color: Colors.white10,
                blurRadius: blur,
                offset: Offset(offset, offset))
          ]),
      child: Center(
        child: StoryCard(
          //imagePath, name, title, location, description
          imagePath: data['postImageUrl'],
          name: data['name'],
          title: data['title'],
          location: data['city'],
          description: data['story'],
          likes: data['likes'],
        ),
      ),
/*            Column(
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: <Widget>[
                        CircularProfileAvatar(
                          'https://lh3.googleusercontent.com/-3KRN8FOLDi8/VHCzsrOwCdI/AAAAAAAABGE/0svb_GUfluIWq_ba8OImXqjLFdSwxPjwACEwYBhgLKtMDAL1OcqxHeusXYQFMXmSyxQKvrutyOr--2kzlYoAYZaOWyHvWvtp8TlsuZA4cQzFpijDkDOqTV0IgNgJgt_u44mBuikFpKpK7_6OVKN5wIit0mVWYg9yTsEbW4hTEMGN7fbSwMppXcvwxuKLr5zHzJ-diTTpqgTh8bzwN1xdwhbu2dn4l-KGhB0g6VCcFxVXAZJdS0z1ut6N4Ez7xRSKI8pIgePtso0w5vSj2vHh-3IPDNwPsCzvZ_JI_T4dq3R286x7Tg7hDP7rWv-IfrMwh2Knxf2SQM-8cKOyamfDcyvH2ufxGFnpcul77_i0DJG4d88fhj5wKzzq1fRc_4oSuRI9a5VoEJ2Oss3HXNYnB4Lv5HiVwzLDm6x0V9vuZUWdn8-DdqrD3_1EqHuDWxvIwQUZGUAW97_F4UOFcl4iwGrhBtBTTGGPGnr03GGThCKB3pLsgaSArjQWPPp5zVd_obBd42iqsq1Gm9SJGFn6VwW2ZiYesgExflbs6fCSAHtC5vraMKraH-giEU_u9pesmoem3vFgSC_C2jqGdTLzmWkFd1kIJzsPOAwkP6PWQLTmlRjEJiTxvAFOE2LEcAkOY1aNBZ70ul4ga7Zf0-7mlH76aEvIw1vOr-AU/w101-h140-p/DSC_0833.JPG', //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                          radius:
                          25, // sets radius, default 50.0
                          backgroundColor: Colors
                              .black12, // sets background color, default Colors.white
                          borderWidth: 1,
                          borderColor: Colors.blue,// sets border, default 0.0
                        ),
                        Text(data['name'], style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(data['title'], style: TextStyle(color: Colors.white),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Yesterday, 9:24 PM",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                      Spacer(),
                      ImageIcon(
                        AssetImage('assets/MapPin.png'),
                        color: Color(0xFF3c6478),//Colors.red,
                      ),
                      //'assets/MapPin.png'),
                      Text(data['city'], style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              ],
            ),
            */
      //Text(data['title'], style: TextStyle(fontSize: 40, color: Colors.white))
    );
  }

  _buildTagPage() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
              InkWell(
                onTap: () => NewPostPage.show(context),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.dstATop),
                      image: AssetImage(
                        'assets/image1.jpg',
                      ),
                    ),
                    //shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Icon(
                            Icons.add_comment,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Click to add your story',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

/*
Widget storyList(datas) {
  return ListView.builder(
    physics: BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    itemCount: datas.length,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            SizedBox(
                width: (index == 0) ? 30 : (index < datas.length - 1) ? 10 : 10),
            MainCard(
              //imagePath, name, title, location, description
              imagePath: datas[index]['postImageUrl'],
              name: datas[index]['name'],
              title: datas[index]['title'],
              location: datas[index]['city'],
              description: datas[index]['story'],
            ),
            SizedBox(
                width: (index == 0) ? 0 : (index < datas.length - 1) ? 0 : 30),
          ],
        ),
      );
    },
  );
}

 */

class FeedPageBackground extends StatelessWidget {
  final screenHeight;

  const FeedPageBackground({Key key, @required this.screenHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ClipPath(
      clipper: BottomShapeClipper(),
      child: Container(
        height: screenHeight * 0.4,
        color: themeData.primaryColor,
      ),
    );
  }
}

class BottomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    Offset curveStartPoint = Offset(0, size.height * 0.85);
    Offset curveEndPoint = Offset(size.width, size.height * 0.85);
    path.lineTo(curveStartPoint.dx, curveStartPoint.dy);
    path.quadraticBezierTo(
        size.width / 2, size.height, curveEndPoint.dx, curveEndPoint.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
