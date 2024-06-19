/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

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

  /// File path: assets/icons/call_3.svg
  SvgGenImage get call3 => const SvgGenImage('assets/icons/call_3.svg');

  /// File path: assets/icons/microphone-2.svg
  SvgGenImage get microphone2 =>
      const SvgGenImage('assets/icons/microphone-2.svg');

  /// File path: assets/icons/microphone-slash.svg
  SvgGenImage get microphoneSlash =>
      const SvgGenImage('assets/icons/microphone-slash.svg');

  /// File path: assets/icons/pause-slash.svg
  SvgGenImage get pauseSlash =>
      const SvgGenImage('assets/icons/pause-slash.svg');

  /// File path: assets/icons/pause.svg
  SvgGenImage get pause => const SvgGenImage('assets/icons/pause.svg');

  /// File path: assets/icons/profile_light_2.svg
  SvgGenImage get profileLight2 =>
      const SvgGenImage('assets/icons/profile_light_2.svg');

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
        call3,
        microphone2,
        microphoneSlash,
        pauseSlash,
        pause,
        profileLight2,
        videoSlash,
        video2,
        volumeHigh,
        volumeSlash
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/bg.png
  AssetGenImage get bg => const AssetGenImage('assets/images/bg.png');

  /// List of all assets
  List<AssetGenImage> get values => [bg];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $FontsGen fonts = $FontsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

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

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size = null,
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size = null,
  }) : _isVecFormat = true;

  final String _assetName;

  final Size? size;
  final bool _isVecFormat;

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
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture(
      _isVecFormat
          ? AssetBytesLoader(_assetName,
              assetBundle: bundle, packageName: package)
          : SvgAssetLoader(_assetName,
              assetBundle: bundle, packageName: package),
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
