import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziyad_book_explorer/provider/favorite_provider.dart';
import 'package:ziyad_book_explorer/screen/detail_screen.dart';
import 'package:ziyad_book_explorer/widget/book_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: Consumer<FavoriteProvider>(builder: (context, favProvider, child) {
        if (favProvider.favorites.isEmpty) {
          return Center(
            child: Text("ORA ENEK SU"),
          );
        }

        return ListView.builder(itemCount: favProvider.favorites.length, itemBuilder: (context, index) {
          final book = favProvider.favorites[index];
          return BookCard(
              book: book, 
              onTap: () {
                Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (_) => DetailScreen(book: book))
                );
              }
              );
        });
      }),
    );
  }

}