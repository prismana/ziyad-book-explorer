import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziyad_book_explorer/models/book.dart';

class FavoriteProvider extends ChangeNotifier {
  // Temporary favorite book
  List<Book> _favorites = [];

  // KEY
  static const String _storageKey = 'favorites';

  // Getter
  List<Book> get favorites => _favorites;

  FavoriteProvider() {
    _loadFromStorage();
  }

  // Check if book has favorite
  bool isFavorite(Book book) {
    return _favorites.any((b) => b.key == book.key);
  }

  // Toggle favorite
  void toggleFavorite(Book book) {
    if (isFavorite(book)) { // remove if it favorite
      _favorites.removeWhere((b) => b.key == book.key);
    } else {
      _favorites.add(book);
    }

    // Save updated list to persistent storage
    _saveToStorage();
    notifyListeners();
  }


  // Load save
  Future<void> _loadFromStorage() async {
    // SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(_storageKey);

    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      _favorites = jsonList.map((json) => Book.fromJson(json)).toList();
      notifyListeners();
    }
  }

  // Save favorite list
  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();

    // Convert Book object to JSON String
    final jsonString = jsonEncode(
        _favorites.map( (b) => b.toJson() ).toList()
    );

    // Store using key
    await prefs.setString(_storageKey, jsonString);
  }
}
