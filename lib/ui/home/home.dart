import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librarymanagerclient/ui/borrow/borrow.dart';
import 'package:librarymanagerclient/ui/return/return.dart';

class Home extends StatelessWidget {
  static const routeName = '/';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Library Manager'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildUserMenu(context),
            _buildManagerMenu(context)
          ],
        ),
      ),
    );
  }

  Widget _buildUserMenu(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('USER MENU'),
        ElevatedButton(
          child: Text('BORROW'),
          onPressed: () {
            Navigator.of(context).pushNamed(Borrow.routeName).then((value) {
              // BORROWボタンを押して戻ってきたら
              if (value == true) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('DONE! (BORROW)'),
                  duration: Duration(seconds: 3),
                ));
              }
            });
          },
        ),
        ElevatedButton(
          child: Text('RETURN'),
          onPressed: () {
            Navigator.of(context).pushNamed(Return.routeName).then((value) {
              // RETURNボタンを押して戻ってきたら
              if (value == true) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('DONE! (RETURN)'),
                  duration: Duration(seconds: 3),
                ));
              }
            });
          },
        ),
        ElevatedButton(
          child: Text('SEARCH'),
          onPressed: () {
            Navigator.of(context).pushNamed('/book_list');
          },
        ),
      ],
    );
  }

  Widget _buildManagerMenu(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('MANAGER MENU'),
        ElevatedButton(
          child: Text('REGISTER'),
          onPressed: () {
            Navigator.of(context).pushNamed('/register');
          },
        ),
        ElevatedButton(
          child: Text('INVENTROY CHECK'),
          onPressed: () {
//            Navigator.of(context).pushNamed('/inventory_check');
          },
        ),
        ElevatedButton(
          child: Text('DEBUG'),
          onPressed: () {
//            Navigator.of(context).pushNamed('/debug');
          },
        ),
      ],
    );
  }
}
