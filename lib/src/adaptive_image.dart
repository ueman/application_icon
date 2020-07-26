import 'package:application_icon/src/adaptive_icon.dart';
import 'package:application_icon/src/app_icon_channel.dart';
import 'package:application_icon/src/tiltable_stack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveImage extends StatelessWidget {
  final AdaptiveIcon icon;

  const AdaptiveImage({Key key, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TiltableStack(
      children: <Widget>[
        Image.memory(icon.background),
        Image.memory(icon.foreground),
      ],
    );
  }
}

class AndroidAdaptiveImage extends StatefulWidget {
  const AndroidAdaptiveImage({Key key}) : super(key: key);

  @override
  _AndroidAdaptiveImageState createState() => _AndroidAdaptiveImageState();
}

class _AndroidAdaptiveImageState extends State<AndroidAdaptiveImage> {
  AdaptiveIcon appIcon;

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
    return AdaptiveImage(icon: appIcon);
  }

  Future<void> loadAppIcon() async {
    final newAppIcon = await ApplicationIcon.getAdaptiveIcon();
    setState(() {
      appIcon = newAppIcon;
    });
  }
}
