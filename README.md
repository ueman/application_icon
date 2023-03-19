# Application Icon

[![pub package](https://img.shields.io/pub/v/application_icon.svg)](https://pub.dev/packages/application_icon) [![likes](https://img.shields.io/pub/likes/application_icon)](https://pub.dev/packages/application_icon/score) [![popularity](https://img.shields.io/pub/popularity/application_icon)](https://pub.dev/packages/application_icon/score) [![pub points](https://img.shields.io/pub/points/application_icon)](https://pub.dev/packages/application_icon/score) [![GitHub Workflow Status](https://github.com/ueman/application_icon/workflows/build/badge.svg?branch=master)](https://github.com/ueman/application_icon/actions?query=workflow%3Abuild)
<!-- [![code coverage](https://codecov.io/gh/ueman/application_icon/branch/master/graph/badge.svg)](https://codecov.io/gh/ueman/application_icon) -->

# Platform support

| Platform | Supported | Remarks |
|----------|:---------:|---------|
| Android  | ✅ | |
| iOS      | ✅ | |
| macOS    | ❌ | |
| Linux    | ❌ | |
| Windows  | ❌ | |
| Web.     | ❌ | |

This package provides a widget which shows the application icon of your app.

It tries to use the highest resolution icon of your app icon on iOS.
On Android, on API levels equal or higher than [26 (Android O)](https://developer.android.com/about/versions/oreo/android-8.0)
it tries to show the [Adaptive Icon](https://developer.android.com/guide/practices/ui_guidelines/icon_design_adaptive)
if available. Otherwise, it just shows the normal application icon.

If an adaptive icon is available, it can be long pressed and dragged around.
It tries to mimic the dragging in the app launcher.

## Setup

First, you will need to add `application_icon` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  application_icon: x.y.z # use the latest version found on pub.dev
```

Then, run `flutter packages get` in your terminal.

## Example

```dart
import 'package:application_icon/application_icon.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          // use AppIcon to show your application icon
          child: AppIconImage(),
        ),
      ),
    );
  }
}
```

If you are not interested in displaying the app icon, you can also load
the image with the `AppIconInfo` class.


# 📣 About the author

- [![Twitter Follow](https://img.shields.io/twitter/follow/ue_man?style=social)](https://twitter.com/ue_man)
- [![GitHub followers](https://img.shields.io/github/followers/ueman?style=social)](https://github.com/ueman)
