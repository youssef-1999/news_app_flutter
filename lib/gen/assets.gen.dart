// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/dark_mic.png
  AssetGenImage get darkMic =>
      const AssetGenImage('assets/images/dark_mic.png');

  /// File path: assets/images/dark_route.png
  AssetGenImage get darkRoute =>
      const AssetGenImage('assets/images/dark_route.png');

  /// Directory path: assets/images/home
  $AssetsImagesHomeGen get home => const $AssetsImagesHomeGen();

  /// File path: assets/images/light_route.png
  AssetGenImage get lightRoute =>
      const AssetGenImage('assets/images/light_route.png');

  /// File path: assets/images/white_mic.png
  AssetGenImage get whiteMic =>
      const AssetGenImage('assets/images/white_mic.png');

  /// List of all assets
  List<AssetGenImage> get values => [darkMic, darkRoute, lightRoute, whiteMic];
}

class $AssetsImagesHomeGen {
  const $AssetsImagesHomeGen();

  /// File path: assets/images/home/busniess-1.png
  AssetGenImage get busniess1 =>
      const AssetGenImage('assets/images/home/busniess-1.png');

  /// File path: assets/images/home/busniess.png
  AssetGenImage get busniess =>
      const AssetGenImage('assets/images/home/busniess.png');

  /// File path: assets/images/home/entertainment-1.png
  AssetGenImage get entertainment1 =>
      const AssetGenImage('assets/images/home/entertainment-1.png');

  /// File path: assets/images/home/entertainment.png
  AssetGenImage get entertainment =>
      const AssetGenImage('assets/images/home/entertainment.png');

  /// File path: assets/images/home/general-1.png
  AssetGenImage get general1 =>
      const AssetGenImage('assets/images/home/general-1.png');

  /// File path: assets/images/home/general.png
  AssetGenImage get general =>
      const AssetGenImage('assets/images/home/general.png');

  /// File path: assets/images/home/helth-1.png
  AssetGenImage get helth1 =>
      const AssetGenImage('assets/images/home/helth-1.png');

  /// File path: assets/images/home/helth.png
  AssetGenImage get helth =>
      const AssetGenImage('assets/images/home/helth.png');

  /// File path: assets/images/home/science-1.png
  AssetGenImage get science1 =>
      const AssetGenImage('assets/images/home/science-1.png');

  /// File path: assets/images/home/science.png
  AssetGenImage get science =>
      const AssetGenImage('assets/images/home/science.png');

  /// File path: assets/images/home/sport-1.png
  AssetGenImage get sport1 =>
      const AssetGenImage('assets/images/home/sport-1.png');

  /// File path: assets/images/home/sport.png
  AssetGenImage get sport =>
      const AssetGenImage('assets/images/home/sport.png');

  /// File path: assets/images/home/technology-1.png
  AssetGenImage get technology1 =>
      const AssetGenImage('assets/images/home/technology-1.png');

  /// File path: assets/images/home/technology.png
  AssetGenImage get technology =>
      const AssetGenImage('assets/images/home/technology.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    busniess1,
    busniess,
    entertainment1,
    entertainment,
    general1,
    general,
    helth1,
    helth,
    science1,
    science,
    sport1,
    sport,
    technology1,
    technology,
  ];
}

abstract final class Assets {
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
