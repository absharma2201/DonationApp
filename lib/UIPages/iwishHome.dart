import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwish_app/Categories/categoryDesignMain.dart';
import 'package:iwish_app/CloudDatabase/firebaseAuthService.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:iwish_app/Models/iWishUser.dart';

import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:provider/provider.dart';

final Color backgroundColor = Color(0xFF093145);

class iWishHomePage extends StatefulWidget {
  @override
  _iWishHomePageState createState() => _iWishHomePageState();
}

class _iWishHomePageState extends State<iWishHomePage>
    with SingleTickerProviderStateMixin {
  final FirebaseAuthService _auth = FirebaseAuthService();

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //Widget bodywidget;// = homePageBody(context);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: <Widget>[
            userProfile(context),
            homePageBody(context),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.person_pin,
          ),
          onPressed: () {
            setState(() {
              if (isCollapsed)
                _controller.forward();
              else
                _controller.reverse();

              isCollapsed = !isCollapsed;
            });
            // _showUserProfile(context);
          },
        ),
      ),
    );
  }

  Widget userProfile(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Container(
          color: Color(0xFF3c6478),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircularProfileAvatar(
                      'https://lh3.googleusercontent.com/-3KRN8FOLDi8/VHCzsrOwCdI/AAAAAAAABGE/0svb_GUfluIWq_ba8OImXqjLFdSwxPjwACEwYBhgLKtMDAL1OcqxHeusXYQFMXmSyxQKvrutyOr--2kzlYoAYZaOWyHvWvtp8TlsuZA4cQzFpijDkDOqTV0IgNgJgt_u44mBuikFpKpK7_6OVKN5wIit0mVWYg9yTsEbW4hTEMGN7fbSwMppXcvwxuKLr5zHzJ-diTTpqgTh8bzwN1xdwhbu2dn4l-KGhB0g6VCcFxVXAZJdS0z1ut6N4Ez7xRSKI8pIgePtso0w5vSj2vHh-3IPDNwPsCzvZ_JI_T4dq3R286x7Tg7hDP7rWv-IfrMwh2Knxf2SQM-8cKOyamfDcyvH2ufxGFnpcul77_i0DJG4d88fhj5wKzzq1fRc_4oSuRI9a5VoEJ2Oss3HXNYnB4Lv5HiVwzLDm6x0V9vuZUWdn8-DdqrD3_1EqHuDWxvIwQUZGUAW97_F4UOFcl4iwGrhBtBTTGGPGnr03GGThCKB3pLsgaSArjQWPPp5zVd_obBd42iqsq1Gm9SJGFn6VwW2ZiYesgExflbs6fCSAHtC5vraMKraH-giEU_u9pesmoem3vFgSC_C2jqGdTLzmWkFd1kIJzsPOAwkP6PWQLTmlRjEJiTxvAFOE2LEcAkOY1aNBZ70ul4ga7Zf0-7mlH76aEvIw1vOr-AU/w101-h140-p/DSC_0833.JPG', //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
                      radius: 50, // sets radius, default 50.0
                      backgroundColor: Colors
                          .transparent, // sets background color, default Colors.white
                      borderWidth: 10, // sets border, default 0.0
                      initialsText: Text(
                        "AB",
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ), // sets initials text, set your own style, default Text('')
                      borderColor: Colors
                          .white, // sets border color, default Colors.white
                      elevation:
                          5.0, // sets elevation (shadow of the profile picture), default value is 0.0
                      foregroundColor: Colors.blueGrey.withOpacity(
                          0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
                      cacheImage:
                          true, // allow widget to cache image against provided url
                      onTap: () {
                        print('Abhinav');
                      }, // sets on tap
                      showInitialTextAbovePicture:
                          true, // setting it true will show initials text above profile picture, default false
                    ),
                  ),
                  Text("Abhinav Sharma",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Container(
                    width: 0.5 * screenWidth,
                    height: 1.0,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton.icon(
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    ),
                    label: Text("Account",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      //UserProfile
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton.icon(
                    icon: Icon(
                      FontAwesomeIcons.donate,
                      color: Colors.white,
                    ),
                    label: Text("Donations",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {},
                  ),
                  SizedBox(height: 10),
                  FlatButton.icon(
                    icon: Icon(
                      FontAwesomeIcons.solidArrowAltCircleUp,
                      color: Colors.white,
                    ),
                    label: Text("Requests",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {},
                  ),
                  SizedBox(height: 10),
                  FlatButton.icon(
                    icon: Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    label: Text("Sign Out",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget homePageBody(context) {
    List<Widget> items = [];
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.5 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: Color(0xFF093145),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.only(right: 16, top: 8),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Container(
                height: 0.4 * screenHeight,
                child: PageView(
                  controller: PageController(viewportFraction: 0.8),
                  scrollDirection: Axis.horizontal,
                  pageSnapping: true,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
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
                                  Padding(
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
                                          //borderColor: Colors.blue,// sets border, default 0.0
                                          initialsText: Text(
                                            "AB",
                                            style: TextStyle(
                                                color: Color(0xFF3c6478)),
                                          ),
                                        ),
                                        Text('by Abhinav Sharma'),
                                      ],
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
                                        Text(
                                          "India",
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
                        )
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Stack(
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
                                  Padding(
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
                                          //borderColor: Colors.blue,// sets border, default 0.0
                                          initialsText: Text(
                                            "AB",
                                            style: TextStyle(
                                                color: Color(0xFF3c6478)),
                                          ),
                                        ),
                                        Text('by Abhinav Sharma'),
                                      ],
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
                                        Text(
                                          "India",
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
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Stack(
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
                                  Padding(
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
                                          //borderColor: Colors.blue,// sets border, default 0.0
                                          initialsText: Text(
                                            "AB",
                                            style: TextStyle(
                                                color: Color(0xFF3c6478)),
                                          ),
                                        ),
                                        Text('by Abhinav Sharma'),
                                      ],
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
                                        Text(
                                          "India",
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
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 0.4 * screenHeight,
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  padding: const EdgeInsets.all(4.0),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  children: <Widget>[
                    ClipPolygon(
                      sides: 6,
                      borderRadius: 5.0,
                      boxShadows: [
                        //PolygonBoxShadow(color: Colors.black, elevation: 1.0),
                        PolygonBoxShadow(color: Colors.white, elevation: 5.0)
                      ],
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return CategoriesHomeScreen();
                          }));
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Request Now',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  letterSpacing: 0.27,
                                  color: Colors.white, //Color(0xFF093145),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ClipPolygon(
                      sides: 6,
                      borderRadius: 5.0,
                      boxShadows: [
                        //PolygonBoxShadow(color: Colors.black, elevation: 1.0),
                        PolygonBoxShadow(color: Colors.white, elevation: 5.0)
                      ],
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return CategoriesHomeScreen();
                          }));
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Donate Now',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  letterSpacing: 0.27,
                                  color: Colors.white, //Color(0xFF093145),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ClipPolygon(
                      sides: 6,
                      borderRadius: 5.0,
                      boxShadows: [
                        //PolygonBoxShadow(color: Colors.black, elevation: 1.0),
                        PolygonBoxShadow(color: Colors.white, elevation: 5.0)
                      ],
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return CategoriesHomeScreen();
                          }));
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Statistics',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  letterSpacing: 0.27,
                                  color: Colors.white, //Color(0xFF093145),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ClipPolygon(
                      sides: 6,
                      borderRadius: 5.0,
                      boxShadows: [
                        //PolygonBoxShadow(color: Colors.black, elevation: 1.0),
                        PolygonBoxShadow(color: Colors.white, elevation: 5.0)
                      ],
                      child: InkWell(
                        splashColor: Colors.white,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return CategoriesHomeScreen();
                          }));
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Events',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  letterSpacing: 0.27,
                                  color: Colors.white, //Color(0xFF093145),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

//CategoriesHomeScreen
