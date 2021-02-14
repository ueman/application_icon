import 'dart:typed_data';

/// Representation of an
/// https://developer.android.com/reference/android/graphics/drawable/AdaptiveIconDrawable
/// This is only supported for Android.
class AdaptiveIcon {
  AdaptiveIcon({
    required this.foreground,
    required this.background,
  });

  /// Foreground of the adaptive icon.
  /// Probably PNG encoded.
  final Uint8List foreground;

  /// Background of the adaptive icon.
  /// Probably PNG encoded.
  final Uint8List background;
}
