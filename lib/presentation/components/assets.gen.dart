/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/icon.png
  AssetGenImage get iconPng => const AssetGenImage('assets/icon/icon.png');

  /// File path: assets/icon/icon.svg
  String get iconSvg => 'assets/icon/icon.svg';

  /// File path: assets/icon/icon_100.png
  AssetGenImage get icon100 => const AssetGenImage('assets/icon/icon_100.png');

  /// File path: assets/icon/icon_200.png
  AssetGenImage get icon200 => const AssetGenImage('assets/icon/icon_200.png');

  /// File path: assets/icon/icon_300.png
  AssetGenImage get icon300 => const AssetGenImage('assets/icon/icon_300.png');

  /// File path: assets/icon/icon_48.png
  AssetGenImage get icon48 => const AssetGenImage('assets/icon/icon_48.png');

  /// List of all assets
  List<dynamic> get values =>
      [iconPng, iconSvg, icon100, icon200, icon300, icon48];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/clear-day.json
  String get clearDay => 'assets/lottie/clear-day.json';

  /// File path: assets/lottie/cloudy.json
  String get cloudy => 'assets/lottie/cloudy.json';

  /// File path: assets/lottie/overcast-day-rain.json
  String get overcastDayRain => 'assets/lottie/overcast-day-rain.json';

  /// File path: assets/lottie/overcast-rain.json
  String get overcastRain => 'assets/lottie/overcast-rain.json';

  /// File path: assets/lottie/overcast.json
  String get overcast => 'assets/lottie/overcast.json';

  /// File path: assets/lottie/partly-cloudy-day.json
  String get partlyCloudyDay => 'assets/lottie/partly-cloudy-day.json';

  /// File path: assets/lottie/snow.json
  String get snow => 'assets/lottie/snow.json';

  /// List of all assets
  List<String> get values => [
        clearDay,
        cloudy,
        overcastDayRain,
        overcastRain,
        overcast,
        partlyCloudyDay,
        snow
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
