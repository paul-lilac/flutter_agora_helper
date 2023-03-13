/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $FontsGen {
  const $FontsGen();

  /// File path: fonts/DMSans-Medium.ttf
  String get dMSansMedium => 'fonts/DMSans-Medium.ttf';

  /// List of all assets
  List<String> get values => [dMSansMedium];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/call-slash.svg
  SvgGenImage get callSlash => const SvgGenImage('assets/icons/call-slash.svg');

  /// File path: assets/icons/microphone-2.svg
  SvgGenImage get microphone2 =>
      const SvgGenImage('assets/icons/microphone-2.svg');

  /// File path: assets/icons/microphone-slash.svg
  SvgGenImage get microphoneSlash =>
      const SvgGenImage('assets/icons/microphone-slash.svg');

  /// File path: assets/icons/video-slash.svg
  SvgGenImage get videoSlash =>
      const SvgGenImage('assets/icons/video-slash.svg');

  /// File path: assets/icons/video_2.svg
  SvgGenImage get video2 => const SvgGenImage('assets/icons/video_2.svg');

  /// File path: assets/icons/volume-high.svg
  SvgGenImage get volumeHigh =>
      const SvgGenImage('assets/icons/volume-high.svg');

  /// File path: assets/icons/volume-slash.svg
  SvgGenImage get volumeSlash =>
      const SvgGenImage('assets/icons/volume-slash.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        callSlash,
        microphone2,
        microphoneSlash,
        videoSlash,
        video2,
        volumeHigh,
        volumeSlash
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $FontsGen fonts = $FontsGen();
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

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
       colorFilter: color == null
          ? null
          : ColorFilter.mode(
              color,
              BlendMode.srcATop,
            ),
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
