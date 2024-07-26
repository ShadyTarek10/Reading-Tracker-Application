import 'package:flutter/material.dart';
import 'package:reader_tracker/Models/book.dart';
import 'package:reader_tracker/utils/BookDetails.dart';

import '../db/database_helper.dart';

class BooksDetailsScreen extends StatefulWidget {
  const BooksDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BooksDetailsScreen> createState() => _BooksDetailsScreenState();
}

class _BooksDetailsScreenState extends State<BooksDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)
        ?.settings
        .arguments as BookDetailsArguments;
    final Book book = args.itemBook;
    final bool isFromSavedScreen = args.isFromSavedScreen;
    final theme = Theme
        .of(context)
        .textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(book.title),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
                  children: [
                  if(book.imageLinks.isNotEmpty)
              Padding(padding: const EdgeInsets.all(8),
          child: Image.network(book.imageLinks['thumbnail'] ?? '',
            fit: BoxFit.cover,),
        ),
        Column(
          children: [
          Text(book.title, style: theme.headlineSmall,),
        Text(book.authors.join(', '), style: theme.labelLarge,),
        Text(('Published: ${book.publishedDate}'),
          style: theme.bodySmall,),
        Text(
          'Page Count: ${book.pageCount}', style: theme.bodySmall,),
        Text('Language: ${book.language}', style: theme.bodySmall,),
        SizedBox(height: 10,),
        SizedBox(
            child: !isFromSavedScreen ? ElevatedButton(
                onPressed: () async {
                  try {
                    int savedInt = await DatabaseHelper.instance.insert(
                        book);
                    SnackBar snackBar = SnackBar(
                        content: Text("Book Saved"));
                    ScaffoldMessenger.of(context).showSnackBar(
                        snackBar);
                  } catch (e) {
                    print("Error: $e ");
                  }
                }, child: Text('Save')) : ElevatedButton.icon(
              onPressed: () async {
                book.isFavorite = !book.isFavorite;
                await DatabaseHelper.instance.toggleFavoriteStatus(book.id, book.isFavorite);
                setState(() {
                });
              },
                icon: Icon(book.isFavorite  ? Icons.favorite: Icons.favorite_outline,color: book.isFavorite ? Colors.red: null,),
                label: Text((book.isFavorite)? 'Favorite':'Add to Favourites')),

        ),
    // Row(
    //   mainAxisAlignment: !isFromSavedScreen ? MainAxisAlignment.spaceEvenly: MainAxisAlignment.center,
    //   children: [
    //     !isFromSavedScreen? ElevatedButton(onPressed: () async{
    //       try{
    //         int savedInt=await DatabaseHelper.instance.insert(book);
    //         SnackBar snackBar= SnackBar(content: Text("Book Saved $savedInt"));
    //         ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //       }catch(e){
    //         print("Error: $e ");
    //       }
    //     },
    //         child: Text('Save')): const SizedBox(),
    //     SizedBox(height: 10,),
    //     ElevatedButton.icon(onPressed: () async {
    //       await DatabaseHelper.instance.toggleFavoriteStatus(book.id, book.isFavorite);
    //
    //
    //     },
    //     icon: Icon(Icons.favorite),
    //     label: Text('Favorite'),)
    //   ],
    // ),
    const SizedBox(height: 10,)
    ,
    Text('Description', style: theme.titleMedium,),
    SizedBox(height: 5,),
    Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
    color: Theme
        .of(context)
        .colorScheme
        .secondary
        .withOpacity(0.1),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: Theme
        .of(context)
        .colorScheme
        .secondary)
    ),
    child: Text(book.description),

    )
    ],
    )
    ],
    ),
    )
    ,
    )
    ,
    );
  }
}
