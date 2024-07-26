import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';

import '../Models/book.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("Favorites"),
      ),
      body: FutureBuilder(
        future: DatabaseHelper.instance.getFavorites(),
        builder: (context,snapshot){
          if (snapshot.connectionState==ConnectionState.waiting ){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.hasError){
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          }
          else if (snapshot.hasData && snapshot.data!.isNotEmpty){
            List<Book> favbooks=snapshot.data!;
            return ListView.builder(
                itemCount: favbooks.length,
                itemBuilder: (context,index){
                  Book book =favbooks[index];
                return Card(
                  child: ListTile(
                    leading:  Image.network(book.imageLinks['thumbnail']?? "",fit: BoxFit.cover,),
                    title: Text(book.title),
                    subtitle: Text(book.authors.join(', ')),
                    trailing: const Icon(Icons.favorite, color: Colors.red,),
                  ),
                );
            });
          }else {
            return Center(
              child: Text("No favorite books found"),
            );
          }
        },
      ),
    );
  }
}
