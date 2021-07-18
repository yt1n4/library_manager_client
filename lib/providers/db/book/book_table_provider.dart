import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:librarymanagerclient/errors/book/BookNotFoundException.dart';
import 'package:librarymanagerclient/models/book/book.dart';
import 'package:librarymanagerclient/providers/client/ndlapi_client.dart';

class BookTableProvider {
  static final String tableName = 'books';

  Future<Book> getBook(String isbn) async {
    var res = await FirebaseFirestore.instance
        .collection(tableName)
        .where('isbn', isEqualTo: isbn)
        .get();

    if (res.docs.length == 0) {
      throw BookNotFoundException();
    }
    var book = res.docs.last.data();

    return Book.fromJson(book);
  }

  Future<List<Book>> getBooks() async {
    var res = await FirebaseFirestore.instance.collection(tableName).get();
    List<Book> books = [];
    res.docs.forEach((element) {
      var book = {...element.data()};
      books.add(Book.fromJson(book));
    });

    return books;
  }

  Future<String> getBookId(String isbn, int seq) async {
    var res = await FirebaseFirestore.instance
        .collection(tableName)
        .where('isbn', isEqualTo: isbn)
        .where('seq', isEqualTo: seq)
        .get();

    if (res.docs.length == 0) {
      throw BookNotFoundException();
    }
    var id = res.docs.last.id;

    return id;
  }

  // seqが必ず順番になっていないと成り立たない
  Future<int> getNumberOfBooks(String isbn) async {
    try {
      return (await getBook(isbn)).seq;
    } on BookNotFoundException catch (e) {
      return 0;
    }
  }

  Future<void> saveBook(Book book) async {
    var data = book.toJson();
    await FirebaseFirestore.instance.collection(tableName).doc().set(data);
  }

  Future<void> saveBookByIsbn(String isbn) async {
    final String title = await NdlApiClient().getBookByIsbn(isbn);
    final String now = DateTime.now().toString();
    final Book book = Book(
      isbn: isbn,
      seq: (await getNumberOfBooks(isbn)) + 1,
      title: title,
      createdAt: now,
      updatedAt: now,
    );
    saveBook(book);
  }

  Future<void> delete(String isbn, int seq) async {
    var id = await getBookId(isbn, seq);
    await FirebaseFirestore.instance.collection(tableName).doc(id).delete();
  }
}
