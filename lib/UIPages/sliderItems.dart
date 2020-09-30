import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iwish_app/UIPages/buttons.dart';
import 'package:iwish_app/UIPages/text_style_utils.dart';
import 'package:iwish_app/UIPages/constants_utils.dart';
import 'iwishwrapper.dart';


import 'authPage.dart';
import '../UIPages/slider.dart';

class SlideItem extends StatelessWidget {
  final int index;

  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    onPressed (){
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return iWishWrapper();
      }
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.width * 0.9,
          width: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(sliderArrayList[index].sliderImageUrl))),
        ),
        SizedBox(
          height: 60.0,
        ),
        BoldText(sliderArrayList[index].sliderHeading, 20.5, kwhite),
        SizedBox(
          height: 15.0,
        ),
        Center(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: index != 2
                  ? NormalText(sliderArrayList[index].sliderSubHeading,kwhite, 12.5)
                  : Column(
                children: <Widget>[
                  NormalText(sliderArrayList[index].sliderSubHeading,kwhite, 12.5),
                  SizedBox(
                    height: 50,
                  ),
                  WideButton("Lets go !!",onPressed),
                ],
              )),
        ),
      ],
    );
  }
}