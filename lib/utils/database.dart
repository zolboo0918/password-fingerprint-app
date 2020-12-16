import 'package:password_save_app/models/password.dart';
import 'package:password_save_app/models/passwordDB.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import '../models/user.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;
  static final pasword = '1234';

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'passwordApp.db'),
      onCreate: (db, version) => _create(db),
      version: 1,
      // password: pasword,
    );
  }

  _create(Database db) {
    db.execute("""
            CREATE TABLE IF NOT EXISTS password (
              password TEXT PRIMARY KEY,
              username TEXT NOT NULL,
              sitename TEXT NOT NULL,
              FOREIGN KEY (username) REFERENCES user (username)
                ON DELETE NO ACTION ON UPDATE NO ACTION
            )""");
    db.execute("""
          CREATE TABLE IF NOT EXISTS users (
            username TEXT PRIMARY KEY,
            password TEXT NOT NULL
          );""");
  }

  Future<bool> newUser(User newUser) async {
    final db = await database;
    var available = isExist(newUser.username).then((value) {
      if (value) {
        return false;
      } else {
        var res = db.rawInsert(
            'INSERT INTO users(password, username) VALUES(?,?)',
            [newUser.password, newUser.username]);
        return res != null ? true : false;
      }
    });
    return available;
  }

  Future<User> login(String username, String password) async {
    var db = await database;
    var res = await db
        .rawQuery(
            "SELECT * FROM users WHERE username = '$username' and password = '$password'")
        .then((users) {
      return users.isNotEmpty
          ? User.fromMap(users.first, username, password)
          : null;
    });
    return res != null ? res : null;
  }

  Future<List<User>> getUsers() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    var users = List.generate(
      maps.length,
      (index) => User(
        username: maps[index]['username'],
        password: maps[index]['password'],
      ),
    );

    return users;
  }

  Future<bool> isExist(String username) async {
    var db = await database;
    return db
        .rawQuery("SELECT * FROM users WHERE username = '$username'")
        .then((users) => users.isEmpty ? false : true);
  }

  Future<bool> insertPass(PasswordDB pass) async {
    final Database db = await database;
    var res = db.rawInsert(
        'INSERT INTO password(password, username, sitename) VALUES(?,?,?)', [
      pass.password.password,
      pass.user,
      pass.siteName
    ]).then((value) => value != null ? true : false);
    // var result = res.then((value) => value != null ? true : false);
    return res;
  }

  Future<List<Password>> getPasswords(String username) async {
    final Database db = await database;
    // final List<Map<String, dynamic>> maps = await
    return db
        .rawQuery("SELECT * FROM password WHERE username = '$username'")
        .then((value) {
      return List.generate(
          value.length,
          (index) => Password(
              name: value[index]['sitename'],
              password: value[index]['password']));
    });
  }

  Future<void> deletePass(Password password) async {
    final db = await database;
    await db.rawDelete(
        "DELETE FROM password WHERE password = ? ", [password.password]);
  }
}
