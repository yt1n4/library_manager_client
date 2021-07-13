import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:librarymanagerclient/errors/book/BookNotFoundException.dart';
import 'package:librarymanagerclient/models/history/book_history.dart';

class BookHistoryTableProvider {
  static final String tableName = 'book_histories';

  Future<void> saveBookHistory(BookHistory bookHistory) async {
    var data = bookHistory.toJson();
    await FirebaseFirestore.instance.collection(tableName).doc().set(data);
  }

  Future<List<BookHistory>> getBookHistories() async {
    var res = await FirebaseFirestore.instance.collection(tableName).get();
    List<BookHistory> bookHistories;
    res.docs.forEach((element) {
      var bookHistory = {...element.data()};
      bookHistories.add(BookHistory.fromJson(bookHistory));
    });

    return bookHistories;
  }

  Future<List<BookHistory>> getBookHistory(String isbn) async {
    var res = await FirebaseFirestore.instance
        .collection(tableName)
        .where('isbn', isEqualTo: isbn)
        .get();

    if (res.docs.length == 0) {
      throw BookNotFoundException();
    }
    List<BookHistory> bookHistories;
    res.docs.forEach((element) {
      var bookHistory = {...element.data()};
      bookHistories.add(BookHistory.fromJson(bookHistory));
    });

    return bookHistories;
  }
}
