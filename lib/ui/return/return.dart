import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:librarymanagerclient/models/book/book_state.dart';
import 'package:librarymanagerclient/models/history/book_history.dart';
import 'package:librarymanagerclient/models/user/user.dart';
import 'package:librarymanagerclient/providers/db/book/book_multiple_tables_provider.dart';
import 'package:librarymanagerclient/providers/db/user/user_table_provider.dart';
import 'package:librarymanagerclient/repositories/check_return_book_repository.dart';
import 'package:librarymanagerclient/ui/borrow/borrow.dart';
import 'package:librarymanagerclient/widgets/nfc_reader_widget.dart';

final userNameProvider = FutureProvider.autoDispose((ref) async {
  final identifier = ref.watch(nfcResultProvider.state);
  if (identifier.isNotEmpty) {
    User user = await UserTableProvider().getUser(identifier);
    return user.name;
  } else {
    return '';
  }
});

// ユーザーが借りている本のリスト
final isBorrowBookProvider = FutureProvider.autoDispose((ref) async {
  final identifier = ref.watch(nfcResultProvider.state);
  if (identifier.isNotEmpty) {
    List<Map<String, dynamic>> bookInfo =
        await BookMultipleTablesProvider().getBookInfoByUser(identifier);
    return bookInfo;
  } else {
    return [];
  }
});

final checkReturnBookRepository =
    StateNotifierProvider.autoDispose((_) => CheckReturnBookRepository());

class Return extends HookWidget {
  static const routeName = '/return';

  Return({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Library Manager'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildUser(),
              _buildReturnBooks(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUser() {
    final String stateReader = useProvider(nfcResultProvider.state);
    final exporterNfc = useProvider(nfcResultProvider);

    final stateUserName = useProvider(userNameProvider);

    final reader = NfcReaderWidget();
    reader.read(stateReader, exporterNfc);

    Widget _displayText() {
      if (stateReader.isEmpty) {
        return Text('社員カードをかざしてください');
      } else {
        return Text('Identifier: $stateReader');
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        _displayText(),
        SizedBox(height: 20),
        stateUserName.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (userName) {
            return Text(userName ?? '社員カードの登録がありません');
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildReturnBooks(BuildContext context) {
    final isBorrowBooks = useProvider(isBorrowBookProvider);

    final exporter = useProvider(checkReturnBookRepository);
    final checkState = useProvider(checkReturnBookRepository.state);

    // 貸し出し中の本をcardで表示
    Widget _bookCard(books, index) {
      return Card(
        child: CheckboxListTile(
          onChanged: (bool value) {
            if (checkState.contains(index)) {
              exporter.remove(index);
            } else {
              exporter.add(index);
            }
          },
          title: Text('${books[index]['title'].toString()}'),
          subtitle: Text('${books[index]['isbn'].toString()}'),
          activeColor: Colors.blue,
          controlAffinity: ListTileControlAffinity.leading,
          value: checkState.contains(index),
          selected: checkState.contains(index),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // 社員カードが読み込まれれば、貸し出し中の本の一覧を表示する
        isBorrowBooks.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (books) {
            if (books.isEmpty) {
              return Text('');
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RaisedButton(
                    child: Text('RETURN!'),
                    onPressed: () async {
                      // チェックボックスで選択された本を返却処理する
                      await Future.forEach(checkState, (ix) async {
                        var bookState = BookState(
                          isbn: books[ix]['isbn'],
                          seq: books[ix]['seq'],
                          isBorrowed: 0,
                          holderId: null,
                          borrowFrom: null,
                          borrowTo: null,
                          createdAt: books[ix]['createdAt'],
                          updatedAt: DateTime.now().toString(),
                        );
                        print(bookState.toJson());
                        final bookHistory =
                            BookHistory.fromJsonBookState(bookState.toJson());
                        print(bookHistory.toJson());
                        await BookMultipleTablesProvider()
                            .saveBookHistoryBatch(bookState, bookHistory);
                      });
                      Navigator.pop(context, true);
                    },
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      '返却したい本を選択してください',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: books.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _bookCard(books, index);
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
