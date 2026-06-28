import 'dart:convert';
import 'package:ziyad_book_explorer/models/book.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = String.fromEnvironment('BASE_URL');

  Future<List<Book>> fetchBooks({String subject = 'children'}) async {
    final uri = Uri.parse('$_baseUrl?subject=$subject&limit=10');

    // GET request
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      final docs = data['docs'] as List<dynamic>;
      
      return docs.map((json) => Book.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load books. Status: ${response.statusCode}');
    }
  }

}