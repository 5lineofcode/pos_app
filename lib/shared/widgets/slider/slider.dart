import 'package:flutter/cupertino.dart';

class SliderModel {
  final String sliderImageUrl;
  final String sliderHeading;
  final String sliderSubHeading;
  final String sliderContent;

  SliderModel({
    @required this.sliderImageUrl,
    @required this.sliderHeading,
    this.sliderSubHeading,
    @required this.sliderContent,
  });
}

final sliderArrayList = [
  SliderModel(
    sliderImageUrl: 'assets/images/biz_safe_3.png',
    sliderHeading: "SAFETY MVP",
    sliderSubHeading: "Your bizSafe L3 Processes",
    sliderContent:
        "Create, Approve, Automate your Risk Assessment, Attendee List and more with one click",
  ),
  SliderModel(
    sliderImageUrl: 'assets/images/lms_step.jpg',
    sliderHeading: "ESS Gaji.id",
    sliderSubHeading: "Your Staff Leaves Process",
    sliderContent: "View, Apply, Approve Staff Leaves with one click",
  ),
];
