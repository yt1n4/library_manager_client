import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:librarymanagerclient/models/user/user.dart';
import 'package:librarymanagerclient/providers/db/user/user_table_provider.dart';

class RegisterUser extends HookWidget {
  static const routeName = '/borrow/register_user';

  RegisterUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // 第2引数に渡す値を設定
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register User'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _inputText(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _inputText(BuildContext context) {
  // borrow画面で読み込んだNFCのidentifierを受け取る
  final String identifier =
      ModalRoute.of(context)!.settings.arguments as String;

  final _formKey = GlobalKey<FormState>();

  String _userName = '';

  // ユーザー情報をDBに登録し、borrow画面に戻す
  Future<void> _registerAndNavigate(BuildContext context) async {
    final String now = DateTime.now().toString();
    final User user = User(
      identifier: identifier,
      name: _userName.replaceAll(RegExp(r'\s'), ''),
      // 借りる・返却のみできるユーザー
      permission: 1,
      createdAt: now,
      updatedAt: now,
    );

    await UserTableProvider().saveUser(user);
    Navigator.of(context).popUntil(ModalRoute.withName('/borrow'));
  }

  // 入力された氏名が正しいか確認するダイアログ
  Future _showAlertDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
        title: new Text('確認'),
        content: new Text('"${_userName}"で氏名を登録してよろしいですか？'),
        actions: <Widget>[
          new SimpleDialogOption(
            child: new Text('OK'),
            onPressed: () async {
              await _registerAndNavigate(context);
            },
          ),
          new SimpleDialogOption(
            child: new Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  return Form(
    key: _formKey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('社員カードの登録がありませんでした。\n登録のため氏名を入力してください。',
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20)),
        Padding(
          padding: EdgeInsets.all(25),
          child: TextFormField(
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              icon: Icon(Icons.person),
              labelText: '氏名',
              hintText: '例) 山田太郎',
            ),
            // _formKey.currentState.save()で呼ばれる
            onSaved: (String? value) async {
              value ??= '';
              _userName = value;
            },
            // 入力を確定した時に呼ばれる
            onFieldSubmitted: (String value) async {
              // _register(value);
            },
            // _formKey.currentState.validate()で呼ばれる
            validator: (String? value) {
              value ??= '';
              if (value.isEmpty) {
                return '必須です';
              }
              return null;
            },
          ),
        ),
        ElevatedButton(
          child: Text('REGISTER'),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              await _showAlertDialog();
            }
          },
        ),
      ],
    ),
  );
}
