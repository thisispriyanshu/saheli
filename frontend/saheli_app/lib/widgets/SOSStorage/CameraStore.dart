import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageListScreen extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/emergency1.jpg',
    'assets/emergency2.jpg',
    'assets/emergency3.jpg',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Storage'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageViewScreen(imagePath: imagePaths[index]),
                ),
              );
            },
            child: Image.asset(
              imagePaths[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}

class ImageViewScreen extends StatelessWidget {
  final String imagePath;

  ImageViewScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caught on 17_02_2023'),
      ),
      body: Center(
        child: PhotoView(
          imageProvider: AssetImage(imagePath),
        ),
      ),
    );
  }
}