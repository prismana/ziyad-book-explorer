import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:ziyad_book_explorer/models/book.dart';
import 'package:ziyad_book_explorer/provider/book_provider.dart';
import 'package:ziyad_book_explorer/screen/detail_screen.dart';
import 'package:ziyad_book_explorer/widget/book_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  
  @override
  void initState() {
    super.initState();
    //  Load book when first screen apears
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(() => context.read<BookProvider>().loadBooks());
  }

  @override
  void dispose() {
    // PERFORMANCE
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // PERFORMANCE
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if(state == AppLifecycleState.resumed) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {

        });
      });
      }
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Explorer"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search books...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                filled: true,
                fillColor: Colors.green
              ),
            ),

          ),
          Expanded(
            child: Consumer<BookProvider>(builder: (context, provider, child) {
              // Loading Spiner
              if (provider.status == BookStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              
              // Error message with retry button
              if (provider.status == BookStatus.error) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(24), 
                    child: Column(
                      children: [
                        Icon(Icons.error_outline, size: 64),
                        SizedBox(height: 16),
                        Text('Something went wrong'),
                        SizedBox(height: 8),
                        Text(
                          provider.errorMessage
                        ),
                        SizedBox(height: 16),
                        ElevatedButton.icon(
                            onPressed: () => provider.loadBooks(),
                            label: Text("Retry"),
                        )
                      ],
                    ),
                  ),
                );
              }

              // Show list of books
              return ListView.builder(
                itemCount: provider.filteredBooks.length,
                itemBuilder: (context, index) {
                  final Book book = provider.filteredBooks[index];
                  return BookCard(book: book, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(book: book)));
                  }
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}