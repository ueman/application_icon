import 'dart:typed_data';

import 'package:application_icon/src/app_icon_channel.dart';
import 'package:flutter/material.dart';

class BitmapAppIcon extends StatefulWidget {
  @override
  _BitmapAppIconState createState() => _BitmapAppIconState();
}

class _BitmapAppIconState extends State<BitmapAppIcon> {
  Uint8List appIcon;

  @override
  void initState() {
    super.initState();
    loadAppIcon();
  }

  @override
  Widget build(BuildContext context) {
    if (appIcon == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Image.memory(appIcon);
  }

  Future<void> loadAppIcon() async {
    final newAppIcon = await ApplicationIcon.getAppIcon();
    setState(() {
      appIcon = newAppIcon;
    });
  }
}
