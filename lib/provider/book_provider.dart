import 'package:flutter/cupertino.dart';
import 'package:ziyad_book_explorer/models/book.dart';
import 'package:ziyad_book_explorer/services/api_service.dart';

enum BookStatus { initial, loading, success, error }

class BookProvider extends ChangeNotifier {
  final ApiService apiService;
  BookProvider({required this.apiService});

  // Internal state variable (private)
  List<Book> _books = [];
  BookStatus _status = BookStatus.initial;
  String _errorMessage = '';
  String _searchQuery = '';

  // Public getter
  List<Book> get books => _books;
  BookStatus get status => _status;
  String get errorMessage => _errorMessage;

  // Filter book based on search query
  List<Book> get filteredBooks {
    if (_searchQuery.isEmpty) return _books;
    // Filter by title (case-sensitive)
    return _books.where((book) => book.title.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  // Fetch initial book list
  Future<void> loadBooks() async {
    _status = BookStatus.loading;
    notifyListeners();

    try { // Call API service
      _books = await apiService.fetchBooks();
      _status = BookStatus.success;
    } catch(e) {
      _errorMessage = e.toString();
      _status = BookStatus.error;
    }

    notifyListeners();
  }

  void updateSearch(String query) {
    _searchQuery = query;
    notifyListeners();
  }

}