import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iwish_app/UIPages/sliderDots.dart';
import 'package:iwish_app/UIPages/sliderItems.dart';
import 'package:iwish_app/UIPages/text_style_utils.dart';
import 'package:iwish_app/UIPages/constants_utils.dart';

import 'package:iwish_app/UIPages/slider.dart';
import 'package:iwish_app/app/charts_page.dart';
import 'package:iwish_app/app/landing_page.dart';

class iwishSliderView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SliderLayoutViewState();
}

class _SliderLayoutViewState extends State<iwishSliderView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) => topSliderLayout();

  Widget topSliderLayout() => Container(
    child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            PageView(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: _onPageChanged,
            children: <Widget>[
              LandingPage(),
             // MyCharts(),
            ],
            //  itemCount: sliderArrayList.length,
             // itemBuilder: (ctx, i) => SlideItem(i),
            ),
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                    child: BoldText(NEXT,14,kwhite),

                  ),
                ),


                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
                    child: BoldText(SKIP,14,kwhite),

                  ),
                ),


                Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < sliderArrayList.length; i++)
                        if (i == _currentPage)
                          SlideDots(true)
                        else
                          SlideDots(false)
                    ],
                  ),
                ),
              ],
            )
          ],
        )),
  );
}

const List<Color> signInGradients = [
  Color(0xFF107896),
  Color(0xFF43ABC9),

];