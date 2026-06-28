class Book {
  final String title;
  final String author;
  final int? firstPublishYear;
  final int? coverId;
  final List<String> subjects;
  final String key;

  Book({
    required this.title,
    required this.author,
    this.firstPublishYear,
    this.coverId,
    required this.subjects,
    required this.key
  });

  // Convert from JSON to Book object
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'Unknown Title',
      author: (json['author_name'] as List<dynamic>?)?.first ?? 'Unknown author',
      firstPublishYear: json['first_publish_year'] as int?,
      coverId: json['cover_i'] as int?,
      subjects: List<String>.from(json['subject'] ?? []),
      key: json['key'] ?? '',
    );
  }

  // Convert Book object to map => for shared_preferences
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'first_publish_year': firstPublishYear,
      'cover_i': coverId,
      'subject': subjects,
      'key': key
    };
  }

  // Full URL for cover image
  String? get coverUrl => coverId != null
      ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
      : null;
}
  