import 'dart:io';

import 'package:sqflite/sqflite.dart';

///数据库创建与关闭管理
class DBManager {
  static const int _DB_VERSION = 1; //数据库版本
  static const String _DB_NAME = 'hgj_flutter_github.db'; //数据库名
  ///数据库实例
  static Database _database;

  ///初始化，打开数据库
  static init() async {
    var dbPath = await getDatabasesPath();
    String path = dbPath + _DB_NAME;
    if (Platform.isIOS) {
      path = dbPath + '/' + _DB_NAME;
    }
    //打开数据库
    _database = await openDatabase(path, version: _DB_VERSION,
        onCreate: (Database db, int version) async {
      //TODO 可以在这里创建表
    });
  }

  ///判断表是否存在
  static isTableExist(String tableName) async {
    await getCurrentDatabase();
    String sql =
        "select * from Sqlite_master where type = 'table' and name = '$tableName'";
    var res = await _database.rawQuery(sql);
    return res != null && res.length > 0;
  }

  ///获取当前数据库实例
  static Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  ///关闭数据库
  static close() {
    _database?.close();
    _database = null;
  }
}
