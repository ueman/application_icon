import 'dart:typed_data';

import 'package:application_icon/src/adaptive_icon.dart';
import 'package:application_icon/src/app_icon_info.dart';
import 'package:flutter/material.dart';

/// Shows the application icon if it is not and [AdaptiveIcon]
class SimpleAppIconImage extends StatefulWidget {
  @override
  _SimpleAppIconImageState createState() => _SimpleAppIconImageState();
}

class _SimpleAppIconImageState extends State<SimpleAppIconImage> {
  Uint8List? appIcon;

  @override
  void initState() {
    super.initState();
    loadAppIcon();
  }

  @override
  Widget build(BuildContext context) {
    if (appIcon == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Image.memory(appIcon!);
    }
  }

  Future<void> loadAppIcon() async {
    final newAppIcon = await AppIconInfo.getAppIcon();
    if (!mounted) {
      return;
    }
    setState(() {
      appIcon = newAppIcon;
    });
  }
}
