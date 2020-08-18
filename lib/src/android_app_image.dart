import 'package:application_icon/src/adaptive_image.dart';
import 'package:application_icon/src/app_icon_info.dart';
import 'package:application_icon/src/simple_app_icon_image.dart';

import 'package:flutter/material.dart';

/// Shows the applications adaptive icon if it has one.
/// Otherwise, the static application icon gets shown.
class AndroidAppImage extends StatefulWidget {
  @override
  _AndroidAppImageState createState() => _AndroidAppImageState();
}

class _AndroidAppImageState extends State<AndroidAppImage> {
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
      return SimpleAppIconImage();
    }
    return AndroidAdaptiveImage();
  }

  Future<void> checkAppIcon() async {
    final value = await AppIconInfo.hasAdaptiveIcon();
    setState(() {
      hasAdaptiveIcon = value;
    });
  }
}
