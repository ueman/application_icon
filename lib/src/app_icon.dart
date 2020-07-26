import 'dart:io';

import 'package:application_icon/src/android_app_icon.dart';
import 'package:application_icon/src/bitmap_app_icon.dart';
import 'package:flutter/material.dart';

/// Shows the application icon.
class AppIcon extends StatelessWidget {
  const AppIcon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidAppIcon();
    } else if (Platform.isIOS) {
      return BitmapAppIcon();
    } else {
      throw Exception('${Platform.operatingSystem} is not supported');
    }
  }
}
