import 'dart:io';

import 'package:application_icon/src/simple_app_icon_image.dart';
import 'package:application_icon/src/android_app_image.dart';

import 'package:flutter/material.dart';

/// Shows the application icon.
class AppIconImage extends StatelessWidget {
  const AppIconImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidAppImage();
    } else {
      return SimpleAppIconImage();
    }
  }
}
