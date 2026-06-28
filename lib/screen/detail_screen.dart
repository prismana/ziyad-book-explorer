import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/book.dart';

class DetailScreen extends StatelessWidget {
  final Book book;

  const DetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
        ],
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                child: book.coverUrl != null
                    ? CachedNetworkImage(
                      imageUrl: book.coverUrl!,
                      width: 160,
                      height: 220,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 160,
                        height: 220,
                        color: Colors.grey[200],
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 160,
                        height: 220,
                        color: Colors.grey[200],
                        child: Icon(Icons.book, size: 80, color: Colors.grey),
                      )
                    ) : Container(
                          width: 160,
                          height: 220,
                          color: Colors.grey[200],
                          child: Icon(Icons.book, size: 80, color: Colors.grey,),
                    ),
              ),
            ),
            SizedBox(height: 16),
            Text("Title: ${book.title}"),
            SizedBox(height: 8),
            Text("Author: ${book.author}"),
            SizedBox(height: 8),
            Text("Key: ${book.key}"),
            SizedBox(height: 8),
            Text("Subject: ${book.subjects}")
          ],
        ),
      ),
    );
  }
}
