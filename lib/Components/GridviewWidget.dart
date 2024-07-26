import 'package:flutter/material.dart';

import '../Models/book.dart';
import '../utils/BookDetails.dart';
class GridviewWidget extends StatelessWidget {
  const GridviewWidget({
    super.key,
    required List<Book> books,
  }) : _books = books;

  final List<Book> _books;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: GridView.builder(
        itemCount: _books.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.6), itemBuilder: (context,index){
      Book book=_books[index];
      return Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/Details', arguments: BookDetailsArguments(itemBook:book, isFromSavedScreen: false));
            // Navigator.push(context, MaterialPageRoute(builder: (context)=> const BooksDetailsScreen()));
          },
          child: Column(
            children: [
              Padding(padding: const EdgeInsets.all(18),
                child: Image.network(book.imageLinks['thumbnail']?? '',scale: 1.2 ,),

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(book.title,style: Theme.of(context).textTheme.titleSmall,overflow: TextOverflow.ellipsis,
                  maxLines: 3,),

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(book.authors.join(', & ') ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,),

              ),

            ],
          ),
        ),
      );


    }));
  }
}
