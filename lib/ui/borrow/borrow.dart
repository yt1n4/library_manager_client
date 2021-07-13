import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:librarymanagerclient/models/history/book_history.dart';
import 'package:librarymanagerclient/models/user/user.dart';
import 'package:librarymanagerclient/models/validators/isbn_validators.dart';
import 'package:librarymanagerclient/providers/db/book/book_multiple_tables_provider.dart';
import 'package:librarymanagerclient/providers/db/book/book_state_table_provider.dart';
import 'package:librarymanagerclient/providers/db/book/book_table_provider.dart';
import 'package:librarymanagerclient/providers/db/user/user_table_provider.dart';
import 'package:librarymanagerclient/repositories/barcode_result_repository.dart';
import 'package:librarymanagerclient/repositories/book_state_repository.dart';
import 'package:librarymanagerclient/repositories/nfc_result_repository.dart';
import 'package:librarymanagerclient/repositories/pick_date_provider.dart';
import 'package:librarymanagerclient/repositories/register_username_repository.dart';
import 'package:librarymanagerclient/ui/register_user/register_user.dart';
import 'package:librarymanagerclient/widgets/barcode_scanner_widget.dart';
import 'package:librarymanagerclient/widgets/date_picker_widget.dart';
import 'package:librarymanagerclient/widgets/nfc_reader_widget.dart';

final barcodeResultProvider =
    StateNotifierProvider.autoDispose((ref) => BarcodeResultRepository());
final nfcResultProvider =
    StateNotifierProvider.autoDispose((ref) => NfcResultRepository());
final userNameProvider =
    StateNotifierProvider.autoDispose((ref) => RegisterUsernameRepository());
final pickDateProvider =
    StateNotifierProvider.autoDispose((_) => PickDateProvider());

final bookProvider = FutureProvider.autoDispose((ref) async {
  final isbn = ref.watch(barcodeResultProvider.state);
  if (isbn.isNotEmpty & IsbnValidator.isValid(isbn)) {
    final book = await BookTableProvider().getBook(isbn);
    final bookState =
        await BookStateTableProvider().searchBookNotBorrowed(isbn);
    return {
      'bookName': book.title,
      'bookSeq': bookState.seq,
      'bookCreatedAt': bookState.createdAt,
    };
  } else {
    return {'bookName': '', 'bookSeq': 0, 'bookCreatedAt': ''};
  }
});

final bookStateProvider =
    StateNotifierProvider.autoDispose((ref) => BookStateRepository());

class Borrow extends HookWidget {
  static const routeName = '/borrow';

  Borrow({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Library Manager'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildBarcodeScanning(),
            _buildNfcReading(context),
            _buildReturnDate(),
            _buildConfirm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBarcodeScanning() {
    final String stateScanner = useProvider(barcodeResultProvider.state);
    final exporterScan = useProvider(barcodeResultProvider);

    final book = useProvider(bookProvider);
    final exporterBookState = useProvider(bookStateProvider);

    Widget _displayText() {
      if (stateScanner.isEmpty) {
        return Text('Scan result here.');
      } else if (IsbnValidator.isValid(stateScanner)) {
        return Text('ISBN: ${stateScanner}');
      } else {
        return Text('ISBNではありません');
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildScanner(exporterScan),
        _displayText(),
        book.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => Text('Error: $err'),
          data: (book) {
            var isbn = '';
            if (IsbnValidator.isValid(stateScanner)) {
              isbn = stateScanner;
            }
            exporterBookState.exportResult({
              'isbn': isbn,
              'seq': book['bookSeq'],
              'createdAt': book['bookCreatedAt']
            });
            return Text(book['bookName']);
          },
        ),
      ],
    );
  }

  Widget _buildScanner(exporter) {
    return FlatButton(
      color: Colors.teal,
      child: Text('BARCODE SCAN', style: TextStyle(color: Colors.white)),
      onPressed: () async {
        exporter.exportResult(
          await BarcodeScannerWidget().scan(),
        );
      },
    );
  }

  Widget _buildNfcReading(BuildContext context) {
    final String stateReader = useProvider(nfcResultProvider.state);
    final exporterNfc = useProvider(nfcResultProvider);

    final String stateUserName = useProvider(userNameProvider.state);
    final exporterUserName = useProvider(userNameProvider);

    final exporterBookState = useProvider(bookStateProvider);

    final reader = NfcReaderWidget();
    reader.read(stateReader, exporterNfc);

    // 氏名登録画面（register_user）への遷移
    _navigateAndDisplay(BuildContext context) async {
      var result = await Navigator.of(context).pushNamed(
        RegisterUser.routeName,
        arguments: stateReader,
      );
      // 氏名登録後から戻ってくる時は返り値がないので、
      // 返り値がなければスナックバーを表示する
      // 戻るボタンで戻ってきた時は返り値があるのでバーを表示しない
      if (result == null) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: new Text('登録完了'),
          ),
        );
        User _user = await UserTableProvider().getUser(stateReader);
        exporterUserName.exportResult(_user.name);
        exporterBookState.exportResult({'holderId': stateReader});
      } else {
        //  登録せずに戻るボタンで戻ってくるとき
        exporterNfc.exportResult('');
      }
    }

    // NFCのidentifierでユーザーが登録されているか確認する
    // 登録がなければ登録画面に遷移させる
    _checkUserRegistered() async {
      if (stateReader.isNotEmpty) {
        try {
          User _user = await UserTableProvider().getUser(stateReader);
          if (_user.name != stateUserName) {
            exporterUserName.exportResult(_user.name);
            exporterBookState.exportResult({'holderId': stateReader});
          }
        } catch (e) {
          _navigateAndDisplay(context);
        }
      }
    }

    _checkUserRegistered(); // providerが stateReader に値が入ったタイミングで関連Widgetを再ビルドしてくれるのでここで呼んでおく

    Widget _displayText() {
      if (stateReader.isEmpty) {
        return Text('社員カードをかざしてください');
      } else if (stateUserName.isEmpty) {
        return Text('Identifier : $stateReader');
      }
      return Text('Identifier: $stateReader\nName     : $stateUserName');
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _displayText(),
      ],
    );
  }

  Widget _buildReturnDate() {
    final DateTime statePicker = useProvider(pickDateProvider.state);
    final PickDateProvider exporter = useProvider(pickDateProvider);
    final exporterBookState = useProvider(bookStateProvider);
    final context = useContext();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Return Date: '),
        RaisedButton(
          onPressed: () async {
            final pickedDate = await DatePickerWidget(
              initialDate: statePicker,
              firstDate: DateTime.now(),
            ).pickDate(context);
            exporter.exportResult(pickedDate);
            await exporterBookState.exportResult({
              'borrowTo':
                  '${pickedDate.year}/${pickedDate.month}/${pickedDate.day}'
            });
          },
          child: Text(
            '${statePicker.year}/${statePicker.month}/${statePicker.day}',
          ),
        )
      ],
    );
  }

  Widget _buildConfirm(context) {
    final exporterBookState = useProvider(bookStateProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          onPressed: () async {
            await exporterBookState.exportResult(
                {'isBorrowed': 1, 'updatedAt': DateTime.now().toString()});

            // ignore: invalid_use_of_protected_member
            final bookState = exporterBookState.state;

            if (bookState.isValid()) {
              print(bookState.toJson());
              final bookHistory =
                  BookHistory.fromJsonBookState(bookState.toJson());
              print(bookHistory.toJson());
              await BookMultipleTablesProvider()
                  .saveBookHistoryBatch(bookState, bookHistory);
              Navigator.pop(context, true);
            } else {
              print(bookState.toJson());
              // 入力されていない項目についてダイアログで表示する
              var _text = '';
              if (!bookState.isValidIsbn) {
                _text += '借りたい本のバーコードを読み込んでください\n';
              }
              if (!bookState.isValidHolderId) {
                _text += '社員カードをかざしてください\n';
              }
              if (!bookState.isValidBorrowTo) {
                _text += '返却日を選択してください\n';
              }
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("ERROR"),
                  content: Text(
                    "$_text",
                    style: TextStyle(height: 2.0),
                  ),
                ),
              );
            }
          },
          child: Text('BORROW!'),
        ),
      ],
    );
  }
}
