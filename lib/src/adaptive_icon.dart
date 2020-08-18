import 'dart:typed_data';

import 'package:flutter/widgets.dart';

/// Representation of an
/// https://developer.android.com/reference/android/graphics/drawable/AdaptiveIconDrawable
/// This is only supported for Android.
class AdaptiveIcon {
  AdaptiveIcon({
    @required this.foreground,
    @required this.background,
  })  : assert(foreground != null),
        assert(background != null);

  /// Foreground of the adaptive icon.
  /// Probably PNG encoded.
  final Uint8List foreground;

  /// Background of the adaptive icon.
  /// Probably PNG encoded.
  final Uint8List background;
}
