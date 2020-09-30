import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iwish_app/UIPages/text_style_utils.dart';
import 'package:iwish_app/UIPages/constants_utils.dart';

import 'package:iwish_app/UIPages/onBoarding.dart';

class iWishSplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<iWishSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF3c6478),
        body:Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(FontAwesomeIcons.heart,color: kwhite,size: 70,),
              SizedBox(height: 50),
              BoldText("iWish",35.0,kwhite),
              TypewriterAnimatedTextKit(
                text: ["Education for All!!"],
                textStyle: TextStyle(fontSize: 30.0,color: kwhite,fontFamily: "nunito"),

                speed: Duration(milliseconds: 150),
              )


            ],
          ),
        )

    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds:4 ),(){
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return iWishOnBoardPage();
      }));
    });
  }
}
const List<Color> signInGradients = [
  Color(0xFF107896),
  Color(0xFF43ABC9),

];
