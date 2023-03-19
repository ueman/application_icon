import 'package:application_icon/src/adaptive_icon.dart';
import 'package:application_icon/src/app_icon_info.dart';
import 'package:application_icon/src/tiltable_stack.dart';
import 'package:flutter/material.dart';

class AdaptiveImage extends StatelessWidget {
  const AdaptiveImage({Key? key, required this.icon}) : super(key: key);

  final AdaptiveIcon icon;

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
  const AndroidAdaptiveImage({Key? key}) : super(key: key);

  @override
  _AndroidAdaptiveImageState createState() => _AndroidAdaptiveImageState();
}

class _AndroidAdaptiveImageState extends State<AndroidAdaptiveImage> {
  AdaptiveIcon? appIcon;

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
      return AdaptiveImage(icon: appIcon!);
    }
  }

  Future<void> loadAppIcon() async {
    final newAppIcon = await AppIconInfo.getAdaptiveIcon();
    setState(() {
      appIcon = newAppIcon;
    });
  }
}
