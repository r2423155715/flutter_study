import 'dart:async';
import 'dart:core';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:synchronized/synchronized.dart';

import 'data_sqlite.dart';

class DatabaseSqliteHelper {
  static const tag = "DatabaseSqliteHelper";
  static const database_name = "Mydb.db";

  //私有构造方法
  DatabaseSqliteHelper._();
  static Database db;
  static DatabaseSqliteHelper _instance;
  static Lock _lockDb = new Lock();
  static Future<DatabaseSqliteHelper> getInstance() async {
    if (_instance == null) {
      await _lockDb.synchronized(() async {
        if (_instance == null) {
          // keep local instance till it is fully initialized.
          // 保持本地实例直到完全初始化。
          var singleton = DatabaseSqliteHelper._();
          await singleton._initDb();
          _instance = singleton;
        }
      });
    }
    return _instance;
  }

  //初始化数据库
  Future _initDb() async {
    var databasesPath = await getApplicationDocumentsDirectory();
    String path = join(databasesPath.path, database_name);
    print("$tag:数据库路径：" + path);
    db = await openDatabase(path,
        version: 2, onCreate: _onCreate, onUpgrade: dbUpgrade);
    return db;
  }

  static void _onCreate(Database db, int version) async {

    await db.execute(DataSqlite.tab_create);//通知消息
  }

  static dbUpgrade(Database db, int oldVersion, int newVersion) {
    print(
        "$tag:数据库更新" + oldVersion.toString() + "<==>" + newVersion.toString());
  }


  // 获取数据库中所有的表
  Future<List> getTables() async {
    List tables = await db
        .rawQuery('SELECT name FROM $database_name');
    print('所有表====${tables}');
    List<String> targetList = [];
    tables.forEach((item) {
      targetList.add(item['name']);
    });
    return targetList;
  }

  // 检查数据库中, 表是否完整, 在部份android中, 会出现表丢失的情况
  Future checkTableIsRight() async {
    List<String> expectTables = ['student']; //将项目中使用的表的表名添加集合中
    List<String> tables = await getTables();
    for (int i = 0; i < expectTables.length; i++) {
      if (!tables.contains(expectTables[i])) {
        return false;
      }
    }
    return true;
  }
}
