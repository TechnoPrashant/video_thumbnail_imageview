# VT ImageView

The plugin generates thumbnails from a video URL and set in in imageView. Just enter the url of the video into the VTImageView() widget. You can also output the image as Uint8List. It Supports Android, IOS & Web.


> Feedback and Pull Requests are most welcome!

## Installation

Add to pubspec.yaml.

```yaml
dependencies:
  ...
  video_thumbnail_imageview: ^0.0.5
```

### How to use.

import video_thumbnail_imageview.dart

```dart
import 'package:video_thumbnail_imageview/video_thumbnail_imageview.dart`';
```

## Usage Example.

```dart
import 'package:flutter/material.dart';
import 'package:video_thumbnail_imageview/video_thumbnail_imageview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video Thumbnail ImageView',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: VTImageView(
          videoUrl:
              "VIDEO URL",
          width: 200.0,
          height: 200.0,
          errorBuilder: (context, error, stack) {
            return Container(
              width: 200.0,
              height: 200.0,
              color: Colors.blue,
              child: Center(
                child: Text("Image Loading Error"),
              ),
            );
          },
        )),
      ),
    );
  }
}
```