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



//Для реальной логики кеширования изображений и загрузки следующей
// страницы изображений потребуется использовать дополнительные библиотеки и API.
// использовал пакет flutter_cache_manager
// для кеширования изображений и http для загрузки изображений с сервера.

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;

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
            // логику загрузки следующей страницы
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
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
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
            onPressed: () async {
              await _saveImageToGallery(imageUrl);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Изображение сохранено в галерее.'),
                ),
              );
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
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Future<void> _saveImageToGallery(String imageUrl) async {
    final file = await DefaultCacheManager().getSingleFile(imageUrl);
    // логика сохранения изображения в галерее с использованием пакета image_gallery_saver или другого подходящего пакета!?
  }
}