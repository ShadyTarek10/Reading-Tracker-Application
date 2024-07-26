import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/book.dart';

class Network{
  ///api endpoint
  static const String _baseURL='https://www.googleapis.com/books/v1/volumes';
  final List<String> _randomQueries = [
    'fiction',
    'science',
    'history',
    'technology',
    'art',
    'romance',
    'mystery',
    'fantasy',
    'adventure',
    'biography',
  ];

  Future <List<Book>> getRandomBooks() async{
    final random = Random();
    final randomQuery = _randomQueries[random.nextInt(_randomQueries.length)];
    var url=Uri.parse('$_baseURL?q=$randomQuery');
    var response= await http.get(url);
    if(response.statusCode==200){
      var data= json.decode(response.body);

      if(data['items']!= null && data['items'] is List){
        List<Book> books =(data['items'] as List <dynamic>).map((book) => Book.fromJson(book as Map<String, dynamic>)).toList();
        return books;
      }
      else{
        throw Exception('Failed to load books');
      }

    }
    else{
      return [];
    }
  }

  Future <List<Book>> searchBooks(String query) async{
     var url=Uri.parse('$_baseURL?q=$query');
     var response= await http.get(url);
     if(response.statusCode==200){
      var data= json.decode(response.body);

      if(data['items']!= null && data['items'] is List){
        List<Book> books =(data['items'] as List <dynamic>).map((book) => Book.fromJson(book as Map<String, dynamic>)).toList();
        return books;
      }
      else{
        throw Exception('Failed to load books');
      }

     }
     else{
       return [];
     }
  }
}