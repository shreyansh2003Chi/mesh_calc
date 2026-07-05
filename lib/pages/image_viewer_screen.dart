import 'package:flutter/material.dart';

class ImageViewerScreen extends StatelessWidget {
  final String imagePath;
  final String title;

  const ImageViewerScreen({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 1.0,
          maxScale: 5.0,
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
