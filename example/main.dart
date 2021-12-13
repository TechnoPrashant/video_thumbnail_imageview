import 'package:flutter/material.dart';

// ignore: avoid_relative_lib_imports
import '../lib/video_thumbnail_imageview.dart';

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
          assetPlaceHolder: 'assest/placeholder.png',
          videoUrl: "VIDEO URL",
          width: 200.0,
          height: 200.0,
          errorBuilder: (context, error, stack) {
            return Container(
              width: 200.0,
              height: 200.0,
              color: Colors.green,
              child: const Center(
                child: Text("error loading Image"),
              ),
            );
          },
        )),
      ),
    );
  }
}
