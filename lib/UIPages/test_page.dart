/*
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SpeedDial(
          backgroundColor: Colors.redAccent,
          closeManually: false,
          child: Icon(Icons.filter_list),
          overlayColor: Colors.amber,
          overlayOpacity: 0.2,
          //curve: Curves.easeIn,
          children: [
            SpeedDialChild(
              child: Text('Helpline'),//Icon(Icons.call),
              //label: 'Call Helpline',
              backgroundColor: Colors.yellow,
              onTap: () {},
            ),
            SpeedDialChild(
              child: Icon(Icons.mail_outline),
              label: 'Send Enquiry',
              backgroundColor: Colors.green,
              onTap: () {},
            ),
            SpeedDialChild(
              child: Icon(Icons.add_comment),
              label: 'Requests',
              backgroundColor: Colors.blue,
              onTap: () {},
            ),
            SpeedDialChild(
              child: Icon(Icons.donut_small),
              label: 'Donations',
              backgroundColor: Colors.red,
              onTap: ()
                {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) {
                        return DonationsPage();
                      }));
                },

            ),
          ],
        ),
/*
return InkWell(
onTap: onTap,
child: Card(
color: Colors.transparent,
//elevation: 8.0,
//margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
child: Container(
height: 100,
decoration: BoxDecoration(
color: Colors.transparent,//Color.fromRGBO(64, 75, 96, .9),
borderRadius: BorderRadius.circular(20.0),

),
child: new Stack(
children: <Widget>[_listItemInfo(context, donation), _listItemThumbnail(context, donation),],
)
),
),

Widget _listItemInfo(BuildContext context, Donation donation) {
  return Container(
    constraints: new BoxConstraints.expand(),
    height: MediaQuery.of(context).size.height,
    margin: new EdgeInsets.only(left: 46.0),
    decoration: new BoxDecoration(
     // color: new Color(0xFF333366),
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black12,
          blurRadius: 10.0,
          offset: new Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(donation.name,
            style: headerTextStyle,
          ),
          new Text(donation.money.toString(),
              style: subHeaderTextStyle

          ),
          new Container(
              height: 2.0,
              width: MediaQuery.of(context).size.width/2,
              color: new Color(0xff00c6ff)
          ),
          new Row(
            children: <Widget>[
              new Icon(Icons.linear_scale),
              new Text('Status',
                style: regularTextStyle,
              ),
              new Icon(Icons.access_time),
              new Text('Date',
                style: regularTextStyle,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


Widget _listItemThumbnail(BuildContext context, Donation donation) {
  return Container(
    margin: new EdgeInsets.symmetric(
        vertical: 16.0
    ),
    alignment: FractionalOffset.centerLeft,
    child: new Image(
      image: new AssetImage('assets/'+ donation.name +'.png'),
      height: 92.0,
      width: 92.0,
    ),
  );
}


   margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
    constraints: new BoxConstraints.expand(),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(height: 4.0),
        new Text(donation.name,
          style: headerTextStyle,
        ),
        new Container(height: 10.0),
        new Text(donation.money.toString(),
            style: subHeaderTextStyle

        ),
        new Container(
            margin: new EdgeInsets.symmetric(vertical: 8.0),
            height: 2.0,
            width: 18.0,
            color: new Color(0xff00c6ff)
        ),
        new Row(
          children: <Widget>[
            new Image.asset("assets/img/ic_distance.png", height: 12.0),
            new Container(width: 8.0),
            new Text('Status:',
              style: regularTextStyle,
            ),
            new Container(width: 24.0),
            new Icon(Icons.access_time, size: 12,),
            new Container(width: 8.0),
            new Text('Date:',
              style: regularTextStyle,
            ),
          ],
        ),
      ],
    ),


*/

ListTile(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.autorenew, color: Colors.white),
          ),
          title: Text(
            donation.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('subvalues',
                        style: TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing: Icon(Icons.chevron_right, color: Colors.white, size: 30.0),
          onTap: onTap,
        ),







class StoryCardScrollWidget extends StatelessWidget {
  StoryCardScrollWidget();
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<FirestoreDatabase>(context, listen: false);
    final storage = Provider.of<StorageService>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    List<Widget> cardList = new List();
    return StreamBuilder<List<Post>>(
      stream: database.postsStream(),
      builder: (context, snapshot) {
        return PostListItemsBuilder<Post>(
          snapshot: snapshot,
          itemBuilder: (context, post) => Dismissible(
            key: Key('donation-${post.id}'),
            background: Container(color: Colors.red),
            //direction: DismissDirection.endToStart,
            //onDismissed: (direction) => _delete(context, donation),
            child:
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:
              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: 0.2 * screenHeight,
                        margin: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/child-baby-tiny-prayer.jpg'),
                              fit: BoxFit.cover,
                            )),
                      ),
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
                                initialsText: Text(
                                  "AB",
                                  style: TextStyle(
                                      color: Color(0xFF3c6478)),
                                ),
                              ),
                              Text(' Abhinav Sharma'),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Our success stories. Tap to read full",
                          //style: titleTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Yesterday, 9:24 PM",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                            ),
                            Spacer(),
                            ImageIcon(
                              AssetImage('assets/MapPin.png'),
                              color: Color(0xFF3c6478),//Colors.red,
                            ),
                            //'assets/MapPin.png'),
                            Text(
                              "Hyderabad",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

            ),
          ),
        );
      },
    );

        List<Widget> cardList = new List();

        for (var i = 0; i < 3; i++) {
          var cardItem = Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child:
                Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 0.2 * screenHeight,
                          margin: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/child-baby-tiny-prayer.jpg'),
                                fit: BoxFit.cover,
                              )),
                        ),
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
                                  initialsText: Text(
                                    "AB",
                                    style: TextStyle(
                                        color: Color(0xFF3c6478)),
                                  ),
                                ),
                                Text(' Abhinav Sharma'),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Our success stories. Tap to read full",
                            //style: titleTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Yesterday, 9:24 PM",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                ),
                              ),
                              Spacer(),
                              ImageIcon(
                                  AssetImage('assets/MapPin.png'),
                                color: Color(0xFF3c6478),//Colors.red,
                              ),
                                  //'assets/MapPin.png'),
                              Text(
                                "Hyderabad",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

          );
          cardList.add(cardItem);
        }
        return PageView(
          controller: PageController(viewportFraction: 0.8),
          scrollDirection: Axis.horizontal,
          children: cardList,
        );
  }
}

 */