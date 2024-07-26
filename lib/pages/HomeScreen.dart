import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reader_tracker/Network/network.dart';
import 'package:reader_tracker/pages/books_details.dart';

import '../Components/GridviewWidget.dart';
import '../utils/BookDetails.dart';
import '../Models/book.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Network netwwork=Network();
  List<Book> _books=[];

  @override
  void initState() {
    super.initState();
    _loadRandomBooks();
  }

  Future<void> _loadRandomBooks() async {
    try {
      List<Book> books = await netwwork.getRandomBooks(); // You need to implement this method in your Network class
      setState(() {
        _books = books;
      });
    } catch (e) {
      print("Couldn't load random books...");
    }
  }
  Future <void>  _searchbooks(String query) async {
    try{
      List<Book> books = await netwwork.searchBooks(query);
      // print("Books : ${books.toString()}");
      setState(() {

        _books=books;
      });

    }
    catch (e){
      print("Didn't get anyhting....");

    }
    setState(() {

    });;
  }
  void RefreshData()
  {
    _loadRandomBooks();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search for a book',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),


                ),
                onSubmitted: (query)=>_searchbooks(query),
              ),
            ),
           GridviewWidget(books: _books)
           // Expanded(
           //   child: SizedBox(
           //     width: double.infinity,
           //
           //     child: ListView.builder(
           //       itemCount: _books.length,
           //       itemBuilder: (context,index){
           //         Book book=_books[index];
           //     return ListTile(
           //       title: Text(book.title),
           //       subtitle: Text(book.authors.join(', & ') ?? ''),
           //     );
           //   })
           //     ,),
           // )
          ],
        ),
      ),
    );
  }
}

