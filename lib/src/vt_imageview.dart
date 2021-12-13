import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VTImageView extends StatelessWidget {
  final String videoUrl;
  final double? width;

  final double? height;

  final double scale;
  final ImageFrameBuilder? frameBuilder;

  final ImageErrorWidgetBuilder? errorBuilder;

  final String? semanticLabel;

  final bool excludeFromSemantics;

  final Color? color;

  final BlendMode? colorBlendMode;

  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final Rect? centerSlice;

  final bool matchTextDirection;

  final bool gaplessPlayback;

  /// Whether to paint the image with anti-aliasing.
  ///
  /// Anti-aliasing alleviates the sawtooth artifact when the image is rotated.
  final bool isAntiAlias;

  /// Used to set the [FilterQuality] of the image.
  ///
  /// Use the [FilterQuality.low] quality setting to scale the image with
  /// bilinear interpolation, or the [FilterQuality.none] which corresponds
  /// to nearest-neighbor.
  final FilterQuality filterQuality;
  final int? cacheWidth;
  final int? cacheHeight;
  final String assetPlaceHolder;

  const VTImageView({
    Key? key,
    required this.videoUrl,
    this.width,
    this.height,
    this.scale: 1.0,
    this.frameBuilder,
    this.errorBuilder,
    this.semanticLabel,
    this.excludeFromSemantics: false,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment: Alignment.center,
    this.repeat: ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection: false,
    this.gaplessPlayback: false,
    this.isAntiAlias: false,
    this.filterQuality: FilterQuality.low,
    this.cacheHeight,
    this.cacheWidth,
    required this.assetPlaceHolder,
  })  : assert(videoUrl != null),
        super(key: key);

  Future<String> getThumbnailFromVideoUrl() async {
    String input = '{"videoUrl" : "$videoUrl"}';
    String url =
        "https://video-thumbnail-generator-pub.herokuapp.com/generate/thumbnail";
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Content-type": "application/json"},
        body: input,
      );
      if (response.statusCode == 200) {
        var data = response.body;
        return data;
      } else {
        throw 'Could not fetch data from api | Error Code: ${response.statusCode}';
      }
    } on Exception catch (e) {
      throw "Error : $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getThumbnailFromVideoUrl(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.data == null) {
              return Image.asset(
                assetPlaceHolder,
                width: width,
                height: height,
                scale: scale,
                frameBuilder: frameBuilder,
                errorBuilder: errorBuilder,
                semanticLabel: semanticLabel,
                excludeFromSemantics: excludeFromSemantics,
                color: color,
                colorBlendMode: colorBlendMode,
                fit: fit,
                alignment: alignment,
                repeat: repeat,
                centerSlice: centerSlice,
                matchTextDirection: matchTextDirection,
                gaplessPlayback: gaplessPlayback,
                isAntiAlias: isAntiAlias,
                filterQuality: filterQuality,
                cacheHeight: cacheHeight,
                cacheWidth: cacheWidth,
              );
            }
            return Image.memory(
              base64Decode(snapshot.data),
              width: width,
              height: height,
              scale: scale,
              frameBuilder: frameBuilder,
              errorBuilder: errorBuilder,
              semanticLabel: semanticLabel,
              excludeFromSemantics: excludeFromSemantics,
              color: color,
              colorBlendMode: colorBlendMode,
              fit: fit,
              alignment: alignment,
              repeat: repeat,
              centerSlice: centerSlice,
              matchTextDirection: matchTextDirection,
              gaplessPlayback: gaplessPlayback,
              isAntiAlias: isAntiAlias,
              filterQuality: filterQuality,
              cacheHeight: cacheHeight,
              cacheWidth: cacheWidth,
            );
        }
        return Container();
      },
    );
  }
}
