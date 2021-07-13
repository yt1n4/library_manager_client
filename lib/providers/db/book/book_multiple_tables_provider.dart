import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:librarymanagerclient/models/book/book.dart';
import 'package:librarymanagerclient/models/book/book_state.dart';
import 'package:librarymanagerclient/models/history/book_history.dart';
import 'package:librarymanagerclient/providers/db/book/book_history_table_provider.dart';
import 'package:librarymanagerclient/providers/db/book/book_state_table_provider.dart';
import 'package:librarymanagerclient/providers/db/book/book_table_provider.dart';

// 本の複数テーブルを扱うクラス
class BookMultipleTablesProvider {
  final bookTableName = BookTableProvider.tableName;
  final bookStateTableName = BookStateTableProvider.tableName;
  final bookHistoryTableName = BookHistoryTableProvider.tableName;

  Future<void> saveBookBatch(String isbn, String title) async {
    String now = DateTime.now().toString();
    int seq = (await BookTableProvider().getNumberOfBooks(isbn)) + 1;

    final Book book = Book(
      isbn: isbn,
      seq: seq,
      title: title,
      createdAt: now,
      updatedAt: now,
    );

    final BookState bookState = BookState(
      isbn: isbn,
      seq: seq,
      isBorrowed: 0,
      holderId: null,
      borrowFrom: null,
      borrowTo: null,
      createdAt: now,
      updatedAt: now,
    );

    WriteBatch batch = FirebaseFirestore.instance.batch();

    var bookRef = FirebaseFirestore.instance
        .collection(bookTableName)
        .doc('${isbn}${seq}');
    var bookStateRef = FirebaseFirestore.instance
        .collection(bookStateTableName)
        .doc('${isbn}${seq}');

    batch.set(bookRef, book.toJson());
    batch.set(bookStateRef, bookState.toJson());
    await batch.commit();
  }

  Future<void> saveBookHistoryBatch(
      BookState bookState, BookHistory bookHistory) async {
    String bookStateId = await BookStateTableProvider()
        .getBookStateId(bookState.isbn, bookState.seq);

    WriteBatch batch = FirebaseFirestore.instance.batch();

    var bookStateRef = FirebaseFirestore.instance
        .collection(bookStateTableName)
        .doc(bookStateId);
    var bookHistoryRef =
        FirebaseFirestore.instance.collection(bookHistoryTableName).doc();

    batch.update(bookStateRef, bookState.toJson());
    batch.set(bookHistoryRef, bookHistory.toJson());
    await batch.commit();
  }

  // BookStateの情報に本のタイトルを追加する
  Future<List<Map<String, dynamic>>> getBookInfo() async {
    List<Book> books = await BookTableProvider().getBooks();
    List<BookState> bookStates = await BookStateTableProvider().getBookStates();
    Map<String, String> isbnTitleMap = {};
    List<Map<String, dynamic>> bookStatesInfo = [];

    books.forEach((book) {
      isbnTitleMap[book.isbn] = book.title;
    });

    bookStates.forEach((bookState) {
      String title = isbnTitleMap[bookState.isbn];
      bookStatesInfo.add({...bookState.toJson(), 'title': title});
    });
    return bookStatesInfo;
  }

  // BookStateの情報に本のタイトルを追加する
  Future<List<Map<String, dynamic>>> getBookInfoByUser(
      String identifier) async {
    List<BookState> bookStates =
        await BookStateTableProvider().getBookStateByUser(identifier);
    List<Map<String, dynamic>> bookInfo = [];

    await Future.forEach(bookStates, (bookState) async {
      var book = await BookTableProvider().getBook(bookState.isbn);
      bookInfo.add({...bookState.toJson(), 'title': book.title});
    });
    return bookInfo;
  }
}
