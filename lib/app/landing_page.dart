import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iwish_app/UIPages/constants_utils.dart';
import 'package:iwish_app/UIPages/router.dart';

import 'package:iwish_app/UIPages/story_card.dart';
import 'package:iwish_app/app/donation_process.dart';
import 'package:iwish_app/app/request_process.dart';
import 'package:iwish_app/app/sign_in_page.dart';


import 'package:iwish_app/jobs/new_post_page.dart';



class LandingPage extends StatefulWidget {

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true).pushNamed(
      Routes.landingPage,
   //   arguments: post,
    );
  }

  @override
  _LandingPageState createState() => new _LandingPageState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _LandingPageState extends State<LandingPage> {
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xFF1b1e44),
                  Color(0xFF2d3447),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.clamp)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

          floatingActionButton:

          FloatingActionButton.extended(
            //backgroundColor: Color(0xFF1b1e44),
            onPressed: ()
          {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) {
                  return SignInPageBuilder();
                }));
          },
            //icon: Icon(FontAwesomeIcons.signInAlt),
            label: Text('Join Now', style: TextStyle(fontSize: 20),),),

          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height*0.4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
                                image: AssetImage('assets/image2.jpg',),
                            ),
                              border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        Container(
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 150,),
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
                                  Text(
                                    "No wish goes unfulfilled.",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headline.apply(color: Colors.white),
                                  ) ,
                                ],
                              ),
                            ),

                            ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            child:  Row(
                              children: <Widget>[
                                Text(
                                  "Our Proud Donors,   ",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline6.apply(color: Colors.white),
                                ),
                                Text(
                                  "Genii who fulfilled our wishes",
                                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                                ),
                              ],
                            )
                        ),
                      ),
                      Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.chevron_left, color: Colors.white,),
                           // Spacer(),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                             //,
                              child: Container(
                                width: MediaQuery.of(context).size.width*0.8,
                                child: ListView(
                                  // This next line does the trick.
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 3,
                                              child: CircleAvatar(
                                                radius: 40,
                                                backgroundImage: AssetImage('assets/imageme.jpg'),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Text('Abhinav Sharma', style: TextStyle(color: Colors.white),)),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 3,
                                              child: CircleAvatar(
                                                radius: 40,
                                                backgroundImage: AssetImage('assets/image7.jpg'),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Text('Megha Sharma', style: TextStyle(color: Colors.white),)),

                                          ],
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 3,
                                              child: CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage: AssetImage('assets/image1.jpg'),
                                              )
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Text('Preeti Gupta', style: TextStyle(color: Colors.white),)),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 3,
                                              child: CircleAvatar(
                                                radius: 40,
                                                backgroundImage: AssetImage('assets/image7.jpg'),
                                              )
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Text('Rajat Kumar', style: TextStyle(color: Colors.white),)),

                                          ],
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 3,
                                              child: CircleAvatar(
                                                radius: 40,
                                                backgroundImage: AssetImage('assets/imageme.jpg'),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Text('Abhinav Sharma', style: TextStyle(color: Colors.white),)),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                           // Spacer(),

                            Icon(Icons.chevron_right, color: Colors.white,),


                          ],
                        ),
                      ),
                      /*
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            child:  Column(
                              children: <Widget>[

                                Text(
                                  " An app to break the barriers and fills the gap between the rich and poor, between the privileged and underprivileged."+
                                  "A world where education is available to all , without the barriers of location or cost.",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle1.apply(color: Colors.white),
                                ),
                              ],
                            )

                        ),

                      ),
                      */
                    //  Divider(height: 20,),
                      Divider(color: Colors.blue,),

                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            child:  Row(
                              children: <Widget>[
                                Spacer(),
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: Image.asset('assets/mappin.png', fit: BoxFit.contain,),

                                ),

                                Text(
                                  "Donate Near You",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline6.apply(color: Colors.white),
                                ),
                                Spacer(),
                              ],
                            )
                        ),
                      ),
                      Divider(),
                      Stack(
                        children: <Widget>[ Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,//MediaQuery.of(context).size.height*0.4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              //colorFilter: new ColorFilter.mode(Colors.black.withOpacity(1), BlendMode.dstATop),
                              image: AssetImage('assets/mapback.JPG',),
                            ),
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                          /*
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.9,
                              height: 100,
                              child:Image.asset('assets/mapper.JPG',) ,
                            ),
                          ),
                          */


          ],
                      ),

                      Divider(color: Colors.blue,),

                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            child:  Text(
                              "How it works",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline6.apply(color: Colors.white),
                            )
                        ),
                      ),
                      Divider(),
                      Text(
                        "Connect the donators to the needy people by bringing all on one single platform."
                        + "Donators now can choose either to look for the requests raised within his location and fulfill them or"
                        + " donate items of their wish."
                        + ""
                        ,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1.apply(color: Colors.white),
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                      return DonationProcess();
                                    }));
                              },
                              child: Container(
                                height: 50,
                                  width: MediaQuery.of(context).size.width*0.4,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.orange,
                                        Colors.yellow,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child:  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(FontAwesomeIcons.handHoldingHeart, color: Color(0xFF2d3447),),
                                      ),
                                      SizedBox(width: 4,),
                                      Text(
                                        "Donations",
                                        textAlign: TextAlign.right,
                                        style: Theme.of(context).textTheme.headline.apply(color: Color(0xFF2d3447)),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                      return RequestProcess();
                                    }));
                              },
                              child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width*0.4,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.orange,
                                        Colors.yellow,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 6.0,
                                      ),
                                    ],
                                  ),
                                  child:  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(FontAwesomeIcons.hands, color: Color(0xFF2d3447),),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "Requests",
                                        textAlign: TextAlign.right,
                                        style: Theme.of(context).textTheme.headline.apply(color: Color(0xFF2d3447)),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          ),

                        ],
                      ),

                      Divider(),

                      Divider(color: Colors.blue,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            child:  Column(
                              children: <Widget>[
                                Text(
                                  "Follow Us",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subhead.apply(color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.facebook, size: 30, color: Colors.white,),
                                      Spacer(),
                                      Icon(FontAwesomeIcons.instagram,  size: 30, color: Colors.white,),
                                      Spacer(),
                                      Icon(FontAwesomeIcons.twitter,  size: 30, color: Colors.white,),
                                    ],
                                  ),
                                ),
                              ],
                            )

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
                          Row(
                            children: <Widget>[
                              Spacer(),
                              Icon(FontAwesomeIcons.handHoldingHeart, size: 40, color: Colors.white,),
                              Spacer(),
                              Text(
                                "iWish",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline.apply(color: Colors.white),
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
                Divider(height: 100,),

              ],
            ),
          ),
        ),
      ),
    );
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