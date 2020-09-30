import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwish_app/Models/posts.dart';
import 'package:iwish_app/UIPages/constants_utils.dart';
import 'package:iwish_app/UIPages/details_page.dart';
import 'package:iwish_app/UIPages/story_detail.dart';


//This are the stars of the App, the main Widgets displaying covers of Locations.
class StoryCard extends StatefulWidget {
  //Variables for datas recieved from json.
  //imagePath, name, title, location, description
  final String imagePath;
  final String name;
  final String title;
  final String location;
  final String description;
  final int likes;

  //Importing datas from json via explore_page.dart
  StoryCard({
    this.imagePath,
    this.name,
    this.title,
    this.location,
    this.description,
    this.likes,
  });

  @override
  _StoryCardState createState() => _StoryCardState();
}

class _StoryCardState extends State<StoryCard> {
  final Firestore locationsFSI = Firestore.instance;

  bool showHeart = false;
  bool liked = false;
  int likeCount;

  GestureDetector buildLikeIcon() {
    Color color;
    IconData icon;

    if (liked) {
      color = Colors.pink;
      icon = FontAwesomeIcons.solidHeart;
    } else {
      color = Colors.white;
      icon = FontAwesomeIcons.solidHeart;
    }

    return GestureDetector(
        child: Icon(
          icon,
          size: 25.0,
          color: color,
        ),
        onTap: () {
          // _likePost();
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Creates Details Page for respective Data.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => StoryDetail(
              //imagePath, name, title, location, description
              imagePath: widget.imagePath,
              name: widget.name,
              title: widget.title,
              description: widget.description,
              location: widget.location,
              likes: widget.likes,
            ),
          ),
        );
      },
      child: Hero(
        tag: widget.title + 'StoryCard',
        child: Container(
          width: MediaQuery.of(context).size.width - 60,
          padding: EdgeInsets.symmetric(horizontal: 35),
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.white),
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[300],
            image: DecorationImage(
              image:
                  widget.imagePath == null ?
                  'assets/Books.png':
                      NetworkImage(widget.imagePath),
                      //trendingNews[i]['urlToImage'] ==
                //                                                null
                //                                            ? Image.asset(
                //                                                'images/imgPlaceholder.png',
                //                                              ).toString()
                //                                            : trendingNews[i]['urlToImage'],

              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2),
                BlendMode.multiply,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end, //Arranges from bottom.
            children: <Widget>[
              Material(
                //Title
                color: Colors.transparent,
                child: Text(
                  widget.title,// + widget.likes.toString(),
                  textAlign: TextAlign.left,
                  maxLines: 3,
                  style: TextStyle(
                    color: Colors.white,
                    //fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  buildLikeIcon(),
                  SizedBox(width: 5,),
                  Text(
                    "${widget.likes == null ? ' 1 Like' : widget.likes.toString() + ' Likes'}",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }

  void _likePost() {
    //var userId = googleSignIn.currentUser.id;
    // bool _liked = likes[userId] == true;


    if (!liked) {
      //  print('liking');
      //  reference.document(postId).updateData({'likes.$userId': true});

      // addActivityFeedItem();

      setState(() {
        likeCount = likeCount + 1;
        liked = true;
        //likes[userId] = true;
        //  showHeart = true;
      });

    }
  }

}



class FeedCard extends StatefulWidget {
  final String imagePath;
  final String name;
  final String title;
  final String location;
  final String description;
  final int index;
  final int likes;

  //Importing datas from json via explore_page.dart
  FeedCard({
    this.imagePath,
    this.name,
    this.title,
    this.location,
    this.description,
    this.index,
    this.likes,
  });

  @override
  _FeedCardState createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {

  bool showHeart = false;
  bool liked = false;
  int likeCount;

  GestureDetector buildLikeIcon() {
    Color color;
    IconData icon;

    if (liked) {
      color = Colors.pink;
      icon = FontAwesomeIcons.solidHeart;
    } else {
      color = Color(0xFF1b1e44);
      icon = FontAwesomeIcons.solidHeart;
    }

    return GestureDetector(
        child: Icon(
          icon,
          size: 25.0,
          color: color,
        ),
        onTap: () {
          // _likePost();
        });
  }

  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      // color: Colors.blueAccent,
      height: 160,
      child: InkWell(
        onTap: (){
          // Creates Details Page for respective Data.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => StoryDetail(
                //imagePath, name, title, location, description
                imagePath: widget.imagePath,
                name: widget.name,
                title: widget.title,
                description: widget.description,
                location: widget.location,
                likes: widget.likes,
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
                      widget.imagePath,

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
                        style: Theme.of(context).textTheme.subhead.apply(color: Color(0xFF1b1e44)),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Row(
                        children: <Widget>[
                          buildLikeIcon(),
                          SizedBox(width: 5,),
                          Text(
                            "${widget.likes == null ? ' 1 Like' : widget.likes.toString() + ' Likes'}",
                            style: TextStyle(color: Color(0xFF1b1e44)),
                          ),
                        ],
                      ),
                    ),
                    // it use the available space
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5, // 30 padding
                        vertical: kDefaultPadding / 4, // 5 top and bottom
                      ),
                      decoration: BoxDecoration(
                        color: widget.index.isEven ? kSecondaryColor: kBlueColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                          widget.name,// + widget.likes.toString(),
                        style: Theme.of(context).textTheme.button,
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

  void _likePost() {
    //var userId = googleSignIn.currentUser.id;
    // bool _liked = likes[userId] == true;


    if (!liked) {
      //  print('liking');
      //  reference.document(postId).updateData({'likes.$userId': true});

      // addActivityFeedItem();

      setState(() {
        likeCount = likeCount + 1;
        liked = true;
        //likes[userId] = true;
        //  showHeart = true;
      });

    }
  }
}