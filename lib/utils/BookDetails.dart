
import '../Models/book.dart';

class BookDetailsArguments{

  final Book itemBook;
  final bool isFromSavedScreen;
  BookDetailsArguments({ required this.isFromSavedScreen, required this.itemBook});


}