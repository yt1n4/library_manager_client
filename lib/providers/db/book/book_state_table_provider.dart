import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:librarymanagerclient/errors/book/BookStateNotFoundException.dart';
import 'package:librarymanagerclient/models/book/book_state.dart';

class BookStateTableProvider {
  static final String tableName = 'book_states';

  Future<BookState> getBookState(String isbn, int seq) async {
    var res = await FirebaseFirestore.instance
        .collection(tableName)
        .where('isbn', isEqualTo: isbn)
        .where('seq', isEqualTo: seq)
        .get();

    if (res.docs.length == 0) {
      throw BookStateNotFoundException();
    }
    var bookState = {...res.docs.last.data()};

    return BookState.fromJson(bookState);
  }

  Future<String> getBookStateId(String isbn, int seq) async {
    var res = await FirebaseFirestore.instance
        .collection(tableName)
        .where('isbn', isEqualTo: isbn)
        .where('seq', isEqualTo: seq)
        .get();

    if (res.docs.length == 0) {
      throw BookStateNotFoundException();
    }
    var bookStateId = res.docs.last.id;

    return bookStateId;
  }

  // Search for books that are not borrowed.
  Future<BookState> searchBookNotBorrowed(String isbn) async {
    var res = await FirebaseFirestore.instance
        .collection(tableName)
        .where('isbn', isEqualTo: isbn)
        .where('isBorrowed', isEqualTo: 0)
        .get();

    if (res.docs.length == 0) {
      throw BookStateNotFoundException();
    }
    var bookState = {...res.docs.last.data()};

    return BookState.fromJson(bookState);
  }

  Future<void> updateBookState(BookState bookState) async {
    String bookStateId = await getBookStateId(bookState.isbn, bookState.seq);
    Map<String, dynamic> data = bookState.toJson();

    await FirebaseFirestore.instance
        .collection(tableName)
        .doc(bookStateId)
        .update(data);
  }

  Future<List<BookState>> getBookStates() async {
    var res = await FirebaseFirestore.instance
        .collection(tableName)
        .orderBy('createdAt', descending: true)
        .get();
    List<BookState> bookStates = [];
    res.docs.forEach((element) {
      var book = {...element.data()};
      bookStates.add(BookState.fromJson(book));
    });

    return bookStates;
  }

  Future<List<BookState>> getBookStateByUser(String holderId) async {
    var res = await FirebaseFirestore.instance
        .collection(tableName)
        .where('holderId', isEqualTo: holderId)
        .get();
    if (res.docs.length == 0) {
      throw BookStateNotFoundException();
    }
    List<BookState> bookStates = [];
    res.docs.forEach((element) {
      var book = {...element.data()};
      bookStates.add(BookState.fromJson(book));
    });

    return bookStates;
  }
}
