import 'package:flutter/material.dart';
import 'package:iwish_app/Models/iWishUser.dart';
import 'package:iwish_app/UIPages/iwishwrapper.dart';
//import 'package:iwish_app/UIPages/slider_view.dart';
import 'package:iwish_app/UIPages/theme.dart' as Theme;
import 'package:provider/provider.dart';
//import 'package:iwish_app/CloudDatabase/firebaseAuthService.dart';

class iWishOnBoardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LandingPageState();
}

class _LandingPageState extends State<iWishOnBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.Colors.loginGradientStart,
      body: onBordingBody(),
    );
  }

  Widget onBordingBody() => Container(
        // ignore: missing_required_param
        child: StreamProvider<iWishUser>.value(
            //value: FirebaseAuthService().currentUser(),
            child: iWishWrapper()),
      );
}
