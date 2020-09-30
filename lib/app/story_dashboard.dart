import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
import 'package:iwish_app/UIPages/constants_utils.dart';
import 'package:iwish_app/UIPages/story_card.dart';
import 'package:iwish_app/UIPages/story_detail.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Color(0xFF1b1e44),
      body: FeedBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Text('Articles'),
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add_comment),
          onPressed: () {},
        ),
      ],
    );
  }
}



class FeedBody extends StatefulWidget {
  @override
  _FeedBodyState createState() => _FeedBodyState();
}

class _FeedBodyState extends State<FeedBody> {



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
          SearchBox(onChanged: (value) {}),
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
                                child: FeedCard(
                                  //imagePath, name, title, location, description
                                  imagePath: slideList[index]['postImageUrl'],
                                  name: slideList[index]['name'],
                                  title: slideList[index]['title'],
                                  location: slideList[index]['city'],
                                  description: slideList[index]['story'],
                                  likes: slideList[index]['likes'],
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

/*


 */

  Stream _queryDb() {

    // Make a Query
    Query query = db.collectionGroup('posts');
    // Map the documents to the data payload
    slides = query.snapshots().map((list) => list.documents.map((doc) => doc.data));
  }


}

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key key,
    this.onChanged,
  }) : super(key: key);

  final ValueChanged onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 4, // 5 top and bottom
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon: Icon(Icons.search),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}