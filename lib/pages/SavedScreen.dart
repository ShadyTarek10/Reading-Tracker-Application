import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/utils/BookDetails.dart';

import '../Models/book.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // title: const Text("Saved"),
            ),
        body: FutureBuilder(
            future: DatabaseHelper.instance.readAllBooks(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Book? book = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/Details',
                            arguments: BookDetailsArguments(
                                itemBook: book, isFromSavedScreen: true));
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(book!.title),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              print('delete ${book.id}');
                              DatabaseHelper.instance.deleteBook(book.id);
                              setState(() {});
                            },
                          ),
                          leading: Image.network(
                            book.imageLinks['thumbnail'] ?? '',
                            fit: BoxFit.cover,
                          ),
                          subtitle: Column(
                            children: [
                              Text(book.authors.join(', ')),
                              ElevatedButton.icon(
                                  onPressed: () async {
                                    book.isFavorite = !book.isFavorite;
                                    await DatabaseHelper.instance
                                        .toggleFavoriteStatus(
                                            book.id, book.isFavorite);
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    book.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: book.isFavorite ? Colors.red : null,
                                  ),
                                  label: Text((book.isFavorite)
                                      ? 'Favorite'
                                      : 'Add to Favourites'))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              else{
                return Center(
                  child: Text("No saved books found"),
                );
              }
            }));
  }
}
