
import 'package:flutter/cupertino.dart';
import 'package:iwish_app/UIPages/constants_utils.dart';

class Slider {
  final String sliderImageUrl;
  final String sliderHeading;
  final String sliderSubHeading;

  Slider(
      {@required this.sliderImageUrl,
        @required this.sliderHeading,
        @required this.sliderSubHeading});
}

final sliderArrayList = [
  Slider(
      sliderImageUrl: 'assets/child-baby-tiny-prayer.jpg',
      sliderHeading: SLIDER_HEADING_1,
      sliderSubHeading: SLIDER_DESC),
  Slider(
      sliderImageUrl: 'assets/child-baby-tiny-prayer.jpg',
      sliderHeading: SLIDER_HEADING_2,
      sliderSubHeading: SLIDER_DESC),
  Slider(
      sliderImageUrl: 'assets/child-baby-tiny-prayer.jpg',
      sliderHeading: SLIDER_HEADING_3,
      sliderSubHeading: SLIDER_DESC),
];