import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/book.dart';

class DatabaseHelper {
  static const _databseName = 'book_database.db';
  static const _databaseVersion = 1;
  static const _tableName = 'books';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabse();
    return _database!;
  }

  _initDatabse() async {
    //device/data/dbname.db
    String path = join(await getDatabasesPath(), _databseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $_tableName(
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    authors TEXT NOT NULL,
    favorite INTEGER DEFAULT 0,
    publisher TEXT,
    publishedDate TEXT,
    description TEXT,
    pageCount INTEGER,
    language TEXT,
    imageLinks TEXT,
    previewLink TEXT,
    infoLink TEXT
    )''');
  }

  Future<int> insert(Book book) async {
    Database db = await instance.database;
    return await db.insert(_tableName, book.toJson());
  }

  Future<List<Book>> readAllBooks() async {
    Database db = await instance.database;
    var books = await db.query(_tableName);
    return books.isNotEmpty
        ? books.map((bookData) => Book.fromJsonDatabase(bookData)).toList()
        : [];
  }

  Future<int> toggleFavoriteStatus(String id, bool isFavorite) async {
    Database db = await instance.database;
    return await db.update(_tableName, {'favorite': isFavorite ? 1 : 0},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteBook(String id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: 'id=?', whereArgs: [id]);
  }

  Future <List<Book>> getFavorites () async {
    Database db = await instance.database;
    var favbooks = await db.query(_tableName,where: 'favorite=?' ,whereArgs: [1]);
    return favbooks.isNotEmpty
        ? favbooks.map((bookData) => Book.fromJsonDatabase(bookData)).toList()
        : [];

  }
}
