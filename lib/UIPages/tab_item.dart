import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwish_app/UIPages/keys.dart';
import 'package:iwish_app/UIPages/strings.dart';


enum TabItem { feed, donations, account, requests,  stats,}

class TabItemData {
  const TabItemData(
      {@required this.key, @required this.title, @required this.icon});

  final String key;
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.feed: TabItemData(
      key: Keys.feedTab,
      title: Strings.feed,
      icon: Icons.home,
    ),
    TabItem.stats: TabItemData(
      key: Keys.statsTab,
      title: Strings.stats,
      icon: FontAwesomeIcons.chartBar,
    ),
    TabItem.donations: TabItemData(
      key: Keys.donationsTab,
      title: Strings.donations,
      icon: FontAwesomeIcons.handHoldingHeart,
    ),
    TabItem.requests: TabItemData(
      key: Keys.requestsTab,
      title: Strings.requests,
      icon: FontAwesomeIcons.hands,
    ),
    TabItem.account: TabItemData(
      key: Keys.accountTab,
      title: Strings.account,
      icon: Icons.info_outline,
    ),

  };
}