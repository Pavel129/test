import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageGridScreen(),
    );
  }
}

class ImageGridScreen extends StatefulWidget {
  @override
  _ImageGridScreenState createState() => _ImageGridScreenState();
}

class _ImageGridScreenState extends State<ImageGridScreen> {
  final List<String> imageUrls = [
    "https://example.com/image1.jpg",
    "https://example.com/image2.jpg",
    // Добавьте здесь ссылки на остальные изображения
  ];

  int currentPage = 0;
  int itemsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Галерея изображений'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: currentPage * itemsPerPage + itemsPerPage,
        itemBuilder: (BuildContext context, int index) {
          if (index >= imageUrls.length) {
            // загрузка следующей страницы изображений при достижении конца списка
            // здесь добавляем логику загрузки следующей страницы
            return CircularProgressIndicator();
          }
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ImageViewScreen(imageUrl: imageUrls[index]),
              ));
            },
            child: Hero(
              tag: imageUrls[index],
              child: CachedNetworkImage(
                imageUrl: imageUrls[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ImageViewScreen extends StatelessWidget {
  final String imageUrl;

  ImageViewScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Просмотр изображения'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              //здесь добавляем логику сохранения изображения в галерею
            },
          ),
        ],
      ),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
