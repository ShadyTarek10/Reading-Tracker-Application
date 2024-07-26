import 'dart:convert';

import 'package:flutter/material.dart';
// https://www.googleapis.com/books/v1/volumes?q=

class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String publisher;
  final String publishedDate;
   bool isFavorite;
  final String description;
  // final Map<String, String> industeryIdentifiers;
  final int pageCount;
  final String language;
  final Map<String, String> imageLinks;
  final String previewLink;
  final String infoLink;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    this.isFavorite = false,
    required this.description,
    // required this.industeryIdentifiers,
    required this.pageCount,
    required this.language,
    required this.imageLinks,
    required this.previewLink,
    required this.infoLink});

  factory Book.fromJson(Map<String, dynamic> json){
    var volumeinfo = json['volumeInfo'] ?? {};
    return Book(
        id: json['id'] ?? '',
        title: volumeinfo['title'],
        authors: (volumeinfo['authors'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
        publisher: volumeinfo['publisher'] ?? '',
        publishedDate: volumeinfo['publishedDate'] ?? '',
        description: volumeinfo['description'] ?? '',
        // industeryIdentifiers: {for( var item in volumeinfo['industeryIdentifiers'] as List <dynamic>? ?? [])
        //                   item['type'] as String? ?? '' : item['identifier'] as String? ?? ''
        // },
        pageCount: volumeinfo['pageCount'] ?? 0,

        language: volumeinfo['language'] ?? '',
        imageLinks: (volumeinfo['imageLinks'] as Map <String, dynamic>? ?? {} ).map((key,value)=> MapEntry(key, value.toString())),
        previewLink: volumeinfo['previewLink'] ?? '',
        infoLink: volumeinfo['infoLink'] ?? ''
    );
  }

  Map<String , dynamic > toJson(){
    return {
      'id': id,
      'title': title,
      'authors': json.encode(authors),
      'publisher':publisher,
      'publishedDate':publishedDate,
      'description': description,
      'favorite': isFavorite ? 1: 0,
      // 'industeryIdentifiers': json.encode(industeryIdentifiers),
      'pageCount': pageCount,
      'language':language,
      'imageLinks': json.encode(imageLinks),
      'previewLink': previewLink,
      'infoLink':infoLink,
    };

  }

  factory Book.fromJsonDatabase(Map<String, dynamic> jsonObject){

    return Book(
      id: jsonObject['id'] as String,
      title: jsonObject['title'] as String,
      authors: (jsonObject['authors'] is String
          ? (json.decode(jsonObject['authors']) as List).map((e) => e as String).toList()
          : (jsonObject['authors'] as List).map((e) => e as String).toList()) ?? [],
      publisher: jsonObject['publisher'] as String,
      publishedDate: jsonObject['publishedDate'] as String,
      description: jsonObject['description'] as String,
      // industeryIdentifiers: jsonObject['industryIdentifiers'] is String ? Map.from(json.decode(jsonObject['industryIdentifiers'])): {},
      pageCount: jsonObject['pageCount'] as int,
      language: jsonObject['language'] as String,
      imageLinks: (jsonObject['imageLinks'] is String
          ? (Map<String, dynamic>.from(json.decode(jsonObject['imageLinks']))).map((key, value) => MapEntry(key, value as String))
          : (jsonObject['imageLinks'] as Map).map((key, value) => MapEntry(key as String, value as String))),
      isFavorite: (jsonObject['favorite'] as int) == 1,
      previewLink: jsonObject['previewLink'] as String,
      infoLink: jsonObject['infoLink'] as String,
    );
  }
  @override
  String toString(){
    return "Book: ${this.title}";
  }
}