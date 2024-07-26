import 'package:flutter/material.dart';
import 'package:reader_tracker/Network/network.dart';
import 'package:reader_tracker/pages/FavoriteScreen.dart';
import 'package:reader_tracker/pages/HomeScreen.dart';
import 'package:reader_tracker/pages/SavedScreen.dart';
import 'package:reader_tracker/pages/books_details.dart';

import 'Models/book.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flutter demo',
      theme: ThemeData(
        colorScheme:  ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes:{
        '/Home': ((context)=>HomeScreen()),
        '/Saved': ((context)=>SavedScreen()),
        '/Favorites': ((context)=>FavoriteScreen()),
        '/Details': ((context)=>BooksDetailsScreen()),


      },
      home: const MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex=0;


  final List<Widget> _screens =[
    const HomeScreen(),
    const SavedScreen(),
    const FavoriteScreen(),


  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Reading Tracker'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home),label:"Home" ),
        BottomNavigationBarItem(icon: Icon(Icons.save),label: 'Saved'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorite')

      ],
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        onTap: (value){

          setState(() {
            _currentIndex=value;
          });
        },
      ),
    );
  }
}




