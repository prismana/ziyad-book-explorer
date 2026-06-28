import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ziyad_book_explorer/models/book.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookCard({super.key, required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Cover
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: book.coverUrl != null
                  ? CachedNetworkImage(
                    imageUrl: book.coverUrl!,
                    width: 60,
                    height: 85,
                    fit: BoxFit.cover,
                    // Spiner while loading
                    placeholder: (context, url) => Container(
                      width: 60,
                      height: 85,
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2,),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 60,
                      height: 85,
                      color: Colors.grey[200],
                      child: const Icon(Icons.book, color: Colors.grey,),
                    ),
                  ) :Container(
                  width: 60,
                  height: 85,
                  color: Colors.grey[200],
                  child: const Icon(Icons.book, color: Colors.grey),
                )
              ),
              SizedBox(width: 12),

              // Book Infow
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4,),
                      Text(
                        book.author
                      ),
                      SizedBox(height: 4,),
                    ],
                  )
              ),

              Icon(Icons.chevron_right, color: Colors.green,)
            ],
          ),
        ),
      ),
    );
  }
}