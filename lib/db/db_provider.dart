import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import 'db_manager.dart';

///
/// 数据库表操作基类
///
abstract class BaseDBProvider {
  bool isTableExist = false;

  //返回建表sql
  tableSqlString();

  //返回建表的表名
  tableName();

  tableBaseString(String name, String columnId) {
    return '''
    create table $name (
    $columnId integer primary key autoincrement,
    ''';
  }

  Future<Database> getDB() async {
    return await open();
  }

  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExist = await DBManager.isTableExist(name);
    if (!isTableExist) {
      Database db = await DBManager.getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  open() async {
    if (!isTableExist) {
      await prepare(tableName(), tableSqlString());
    }
    return await DBManager.getCurrentDatabase();
  }
}
