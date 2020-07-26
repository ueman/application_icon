import 'package:application_icon/src/adaptive_image.dart';
import 'package:application_icon/src/app_icon_channel.dart';
import 'package:application_icon/src/bitmap_app_icon.dart';
import 'package:flutter/material.dart';

class AndroidAppIcon extends StatefulWidget {
  @override
  _AndroidAppIconState createState() => _AndroidAppIconState();
}

class _AndroidAppIconState extends State<AndroidAppIcon> {
  bool hasAdaptiveIcon;

  @override
  void initState() {
    super.initState();
    checkAppIcon();
  }

  @override
  Widget build(BuildContext context) {
    if (hasAdaptiveIcon == null) {
      return Center(child: CircularProgressIndicator());
    }
    if (hasAdaptiveIcon == false) {
      return BitmapAppIcon();
    }
    return AndroidAdaptiveImage();
  }

  Future<void> checkAppIcon() async {
    final value = await ApplicationIcon.hasAdaptiveIcon();
    setState(() {
      hasAdaptiveIcon = value;
    });
  }
}
