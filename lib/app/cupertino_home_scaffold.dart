import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwish_app/CloudDatabase/alert_dialogs.dart';
import 'package:iwish_app/CloudDatabase/firebaseAuthService.dart';
import 'package:iwish_app/UIPages/keys.dart';
import 'package:iwish_app/UIPages/strings.dart';
import 'package:iwish_app/UIPages/tab_item.dart';
import 'package:iwish_app/app/account_page.dart';
import 'package:iwish_app/app/cupertino_tab_view_router.dart';
import 'package:iwish_app/jobs/enquiry_page.dart';
import 'package:provider/provider.dart';
import 'package:pedantic/pedantic.dart';


@immutable
class CupertinoHomeScaffold extends StatefulWidget {
  const CupertinoHomeScaffold({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
    @required this.widgetBuilders,
    @required this.navigatorKeys,
  }) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  _CupertinoHomeScaffoldState createState() => _CupertinoHomeScaffoldState();
}

class _CupertinoHomeScaffoldState extends State<CupertinoHomeScaffold> {
  FSBStatus drawerStatus;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.transparent,
/*
          FloatingActionButton(
              child: const Icon(Icons.camera_alt),
          backgroundColor: Colors.green.shade800,
          onPressed: () {},
          ),
          */
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            child: const Icon(
              FontAwesomeIcons.userCircle,
              color: Color(0xFF2d3447),
              size: 40,
            ),
              onPressed: () {
                setState(() {
                  drawerStatus = drawerStatus == FSBStatus.FSB_OPEN ? FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
                });
              }
          ),
          body: FoldableSidebarBuilder(
            drawerBackgroundColor: Color(0xFF2d3447),
            drawer: CustomDrawer(
              closeDrawer: (){
              setState(() {
                drawerStatus = FSBStatus.FSB_CLOSE;
              });
            },),
            screenContents: _build_mainScreen(),
            status: drawerStatus,
          ),

        ),
      ),
    );
  }

  _build_mainScreen() {
    return CupertinoTabScaffold(


      tabBar: CupertinoTabBar(

        backgroundColor: Color(0xFF2d3447),
        key: Key(Keys.tabBar),
        items: [
          _buildItem(TabItem.feed),
          _buildItem(TabItem.donations),
          _buildItem(TabItem.account),
          _buildItem(TabItem.requests),
          _buildItem(TabItem.stats),
          // _buildItem(TabItem.account),
        ],
        onTap: (index) => widget.onSelectTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: widget.navigatorKeys[item],
          builder: (context) => widget.widgetBuilders[item](context),
          onGenerateRoute: CupertinoTabViewRouter.generateRoute,
        );
      },
    );

  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = (drawerStatus != FSBStatus.FSB_OPEN && widget.currentTab == tabItem ) ? Colors.orangeAccent : Colors.white;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
        color: color,
      ),
      title: Text(
        itemData.title,
        key: Key(itemData.key),
        style: TextStyle(color: color),
      ),
    );
  }
}


class CustomDrawer extends StatefulWidget {

  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final Firestore db = Firestore.instance;


  Future<void> _signOut(BuildContext context) async {
    try {
      final FirebaseAuthService auth =
      Provider.of<FirebaseAuthService>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      unawaited(showExceptionAlertDialog(
        context: context,
        title: Strings.logoutFailed,
        exception: e,
      ));
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool didRequestSignOut = await showAlertDialog(
      context: context,
      title: Strings.logout,
      content: Strings.logoutAreYouSure,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.logout,
    ) ??
        false;
    if (didRequestSignOut == true) {
      await _signOut(context);
    }
  }



  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.white,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey.withAlpha(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.person_pin, size: 50,),
                  SizedBox(
                    height: 10,
                  ),

                ],
              )),
          ListTile(
            onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) {
                      return AccountPage();
                    }));
                widget.closeDrawer();
            },
            leading: Icon(Icons.person),
            title: Text(
              "Your Profile",
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped helpline");
            },
            leading: Icon(Icons.phone),
            title: Text("Call helpline"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) {
                    return EnquiryPage();
                  }));
              widget.closeDrawer();
            },
            leading: Icon(Icons.contact_mail),
            title: Text("Enquire"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Notifications");
            },
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              _confirmSignOut(context);
            },
            leading: Icon(Icons.exit_to_app),
            title: Text(Strings.logout),
          ),
        ],
      ),
    );
  }
}