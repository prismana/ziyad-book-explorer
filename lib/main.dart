import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ziyad_book_explorer/provider/book_provider.dart';
import 'package:ziyad_book_explorer/provider/favorite_provider.dart';
import 'package:ziyad_book_explorer/screen/home_screen.dart';
import 'package:ziyad_book_explorer/services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider(apiService: ApiService())..loadBooks()), // call load book when provider created
        ChangeNotifierProvider(create: (_) => FavoriteProvider())
      ],
      child: MaterialApp(
        title: "Ziyad Book Explorer",
        home: HomeScreen(),
      ),
    );
  }
}
