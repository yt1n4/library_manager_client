import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:librarymanagerclient/ui/borrow/borrow.dart';
import 'package:librarymanagerclient/ui/home/home.dart';
import 'package:librarymanagerclient/ui/register/register.dart';
import 'package:librarymanagerclient/ui/register_user/register_user.dart';
import 'package:librarymanagerclient/ui/return/return.dart';
import 'package:librarymanagerclient/ui/search/book_list.dart';

class LibraryManagerApp extends HookWidget {
  const LibraryManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Library Manager",
      routes: <String, WidgetBuilder>{
        Home.routeName: (BuildContext context) => Home(),
        Borrow.routeName: (BuildContext context) => Borrow(),
        Return.routeName: (BuildContext context) => Return(),
        Register.routeName: (BuildContext context) => Register(),
        RegisterUser.routeName: (BuildContext context) => RegisterUser(),
        BookList.routeName: (BuildContext context) => BookList(),
      },
//      home: Home() // Define routes: Home.routeName,
      theme: ThemeData(
        primaryColor: Colors.teal,
        secondaryHeaderColor: Colors.indigo[400],
        backgroundColor: Colors.indigo[100],
        buttonColor: Colors.lightBlueAccent[100],
      ),
    );
  }
}
