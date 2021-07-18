import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:librarymanagerclient/providers/db/book/book_multiple_tables_provider.dart';

class BookList extends HookWidget {
  static const routeName = '/book_list';

  BookList({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.white),
            hintText: '', // search
            hintStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildBookList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBookList(BuildContext context) {
    Widget _bookCard(book, index) {
      return Card(
        color: book[index]['isBorrowed'] == 1 ? Colors.grey : Colors.white,
        child: ListTile(
          title: Text('${book[index]['title']}'),
          subtitle: Text(
              'isbn:${book[index]['isbn']} seq:${book[index]['seq']}\n' +
                  '${book[index]['createdAt']}'),
        ),
      );
    }

    return SizedBox(
      child: FutureBuilder(
        future: BookMultipleTablesProvider().getBookInfo(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            print('error');
            return Text(snapshot.error.toString());
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data != null ? snapshot.data?.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return _bookCard(snapshot.data, index);
            },
          );
        },
      ),
    );
  }
}
