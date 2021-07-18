import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:librarymanagerclient/errors/user/UserNotFoundException.dart';
import 'package:librarymanagerclient/models/user/user.dart';

class UserTableProvider {
  static final String tableName = 'users';

  Future<void> saveUser(User user) async {
    var data = user.toJson();
    await FirebaseFirestore.instance
        .collection(tableName)
        .doc(data['identifier'])
        .set(data);
  }

  Future<List<User>> getUsers() async {
    var res = await FirebaseFirestore.instance.collection(tableName).get();
    List<User> users = [];
    res.docs.forEach((element) {
      var user = {...element.data()};
      users.add(User.fromJson(user));
    });

    return users;
  }

  Future<User> getUser(String identifier) async {
    var res = await FirebaseFirestore.instance
        .collection(tableName)
        .where('identifier', isEqualTo: identifier)
        .get();
    if (res.docs.length == 0) {
      throw UserNotFoundException();
    }
    var user = res.docs.last.data();

    return User.fromJson(user);
  }

  Future<String> getUserId(String identifier) async {
    var res = await FirebaseFirestore.instance
        .collection(tableName)
        .where('identifier', isEqualTo: identifier)
        .get();
    if (res.docs.length == 0) {
      throw UserNotFoundException();
    }
    var id = res.docs.last.id;

    return id;
  }

  Future<void> delete(String identifier) async {
    var id = await getUserId(identifier);
    await FirebaseFirestore.instance.collection(tableName).doc(id).delete();
  }
}
