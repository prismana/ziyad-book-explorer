# ziyad_book_explorer

Book explorer assesment test from Ziyadbook

* Total Project Time: 9 Hour
* Framework: Flutter
* Architecture: MVVM

## Project Structure
lib/
├── main.dart                   # App entry point
├── models/
│   └── book.dart               # Book data model
├── services/
│   └── api_service.dart        # API fetching logic
├── providers/
│   ├── book_provider.dart      # State for book list + search
│   └── favorites_provider.dart # State for favorites (with persistence)
├── screens/
│   ├── home_screen.dart        # Book list + search bar
│   ├── detail_screen.dart      # Book details page
│   └── favorites_screen.dart   # Favorites list page
└── widgets/
└── book_card.dart          # Reusable book card widget

## Getting Started
Run configuration:
adding `--dart-define-from-file=.env.json`
