import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';

class StoryDetail extends StatefulWidget {
  //imagePath, name, title, location, description
  final String imagePath;
  final String name;
  final String location;
  final String description;
  final String title;
  final int likes;
  // final List<dynamic> storyList;

  //Recieving Datas
  StoryDetail({
    this.imagePath,
    this.name,
    this.title,
    this.description,
    this.location,
    this.likes,
  });

  @override
  _StoryDetailState createState() => _StoryDetailState();
}

class _StoryDetailState extends State<StoryDetail> {

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
    return Container(
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),

        body: Container(
          // padding: EdgeInsets.only(top: 5.0),
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child:
                Text(
                    "${widget.title == null ? 'Title Here' : widget.title}",
                    style: Theme.of(context).textTheme.headline.apply(color: Colors.white),
                ),

              ),
              SizedBox(height: 5.0),
              // Image
              Container(
                alignment: Alignment.center,
                // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                  child: Stack(
                    children: <Widget>[
                      Hero(
                        tag: widget.title + 'DetailCard',
                        child: FadeInImage.assetNetwork(
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height/2.5,//280.0,
                          // width: MediaQuery.of(context).size.width,
                          placeholder: 'images/loading.gif',
                          image: widget.imagePath,

                        ),
                      ),
                    ],
                  ),
                ),
              ), // Title

              // Author name
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Posted by : ",
                          style: Theme.of(context).textTheme.body2.apply(color: Colors.white),
                        ),
                        Expanded(
                          child: Text(
                            "${widget.name == null ? 'Ananymous Author' : widget.name.toString()}",
                            style: Theme.of(context).textTheme.subhead.apply(color: Colors.white),
                          ),
                        ),
                        // Share button
                        Container(
                          // alignment: Alignment.center,
                          child: IconButton(
                            icon: Icon(Icons.share),
                            iconSize: 20.0,
                            color: Colors.grey,
                            onPressed: () => Share.share("${widget.title} - ${widget.description}"),
                            //=> Share.share(
                              //  "Click the link to read the article $myUrl"),
                          ),
                        ),

                      ],
                    ),
                    Row(
                      children: <Widget>[
                        buildLikeIcon(),
                        SizedBox(width: 5,),
                        Text(
                          "${widget.likes == null ? ' 1 Like' : widget.likes.toString() + ' Likes'}",
                          style: Theme.of(context).textTheme.subhead.apply(color: Colors.white),
                        ),
                      ],
                    )

                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: Text(
                    "${widget.description == null ? 'Description of Article' : widget.description}",
                    style: Theme.of(context).textTheme.subhead.apply(color: Colors.white)),
              ),
              Divider(),
              /*// Content
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
                child: Text(
                  "${widget.articles['content'] == null ? 'Loading' : widget.articles['content']}",
                  style: Theme.of(context).textTheme.body1,
                ),
              ),*/
              // Read the full article by clicking the URL
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