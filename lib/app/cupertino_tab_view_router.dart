import 'package:flutter/cupertino.dart';
import 'package:iwish_app/UIPages/iwishHome.dart';

class CupertinoTabViewRoutes {
  static const feedPage = '/feedPage';
}

class CupertinoTabViewRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CupertinoTabViewRoutes.feedPage:
        return CupertinoPageRoute(
          builder: (_) => iWishHomePage(),
          settings: settings,
          fullscreenDialog: true,
        );
    }
    return null;
  }
}