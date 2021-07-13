import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:librarymanagerclient/providers/client/ndlapi_client.dart';
import 'package:librarymanagerclient/providers/db/book/book_multiple_tables_provider.dart';
import 'package:librarymanagerclient/repositories/barcode_result_repository.dart';
import 'package:librarymanagerclient/widgets/barcode_scanner_widget.dart';

final barcodeResultProvider =
    StateNotifierProvider.autoDispose((ref) => BarcodeResultRepository());

class Register extends HookWidget {
  static const routeName = '/register';

  Register({Key key}) : super(key: key);

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
          ],
        ),
      ),
    );
  }

  Widget _buildBarcodeScanning() {
    final String stateScanner = useProvider(barcodeResultProvider.state);
    final exporter = useProvider(barcodeResultProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildScanner(exporter),
        FutureBuilder(
          future: NdlApiClient().getBookByIsbn(stateScanner),
          builder: (context, snapshot) {
            if (stateScanner.isEmpty) {
              return Text('Scan result here.');
            } else if (snapshot.connectionState != ConnectionState.done) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              final isbn = stateScanner;
              final title = snapshot.data;
              // https://stackoverflow.com/questions/56894644/how-to-show-a-dialog-inside-a-futurebuilder
              Future.delayed(
                Duration.zero,
                () => showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: new Text('確認'),
                      content: new Text(
                        '書名を以下で登録しますか？\n「${title}」',
                        style: TextStyle(height: 2.0),
                      ),
                      actions: <Widget>[
                        new SimpleDialogOption(
                          child: new Text(
                            'OK',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          onPressed: () async {
                            await BookMultipleTablesProvider()
                                .saveBookBatch(isbn, title);
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text('登録完了'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            Navigator.pop(context);
                          },
                        ),
                        new SimpleDialogOption(
                          child: new Text(
                            'CANCEL',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                ),
              );
              return Text('');
            }
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
        exporter.exportResult(await BarcodeScannerWidget().scan());
      },
    );
  }
}
