import 'package:flutter/material.dart';
import 'package:iwish_app/Models/pieDataChart.dart';
import 'package:iwish_app/app/account_page.dart';
import 'package:iwish_app/UIPages/iwishHome.dart';
import 'package:iwish_app/UIPages/tab_item.dart';
import 'package:iwish_app/app/charts_page.dart';
import 'package:iwish_app/app/cupertino_home_scaffold.dart';
import 'package:iwish_app/app/events_page.dart';
import 'package:iwish_app/app/feed_activities_page.dart';
import 'package:iwish_app/app/geo_listen.dart';
import 'package:iwish_app/jobs/donations_page.dart';
import 'package:iwish_app/jobs/requests_page.dart';
import 'package:iwish_app/location/test_location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.feed;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.feed: GlobalKey<NavigatorState>(),
    TabItem.stats: GlobalKey<NavigatorState>(),
    TabItem.donations: GlobalKey<NavigatorState>(),
    TabItem.requests: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),

  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.feed: (_) => feedActivityPage(),//GeoListenPage(),//feedActivityPage(), //iWishHomePage(),
      TabItem.stats: (_) => MyCharts(),//MyLocation(),//MyCharts(title: 'iWish Statistics'),
      TabItem.donations: (_) => DonationsPage(),
      TabItem.requests: (_) => RequestsPage(),
      TabItem.account: (_) => AccountPage(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
