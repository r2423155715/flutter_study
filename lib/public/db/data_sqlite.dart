import 'package:flutter/cupertino.dart';
import 'data_helper.dart';
import 'data_model.dart';

class DataSqlite {
  static final tag = "DataSqlite";

  //私有构造方法
  DataSqlite._internal() {
    print("数据库：_internalDataSqlite");
  }

  //饿汉模式 直接静态创建
  static final DataSqlite _instance = DataSqlite._internal();

  //单例公开访问点
  factory DataSqlite() => _instance;

  //外部直接调用
  static DataSqlite get instance => new DataSqlite();

  //我的好友
  static const String tab_name = "student";
  static const String tab_create = "create table if not exists  $tab_name ( "
      "_id integer primary key autoincrement , "
      "name text not null, "
      "age int not null"
      ")";

  //插入
  Future<int> insert(DataModel data) async {
    String sql = 'insert into $tab_name '
        '(name, age) values (?, ?)';
    int res = await DatabaseSqliteHelper.db.rawInsert(sql, [
      data.name,
      data.age,
    ]);
    debugPrint(
        "通知消息数据库插入结果$tag：${(res ?? -1) > 0 ? data.toJson().toString() : res.toString()}");
    return res;
  }

//
  // 删除好友
  Future<int>delete(String name,int age) async {
    String sql = "delete from $tab_name where name = ? and age = ?";
    int result = await DatabaseSqliteHelper.db.rawDelete(sql,[name,age]);
    debugPrint("通知消息数据库删除结果$tag：" + result.toString());
    return result;
  }
//
  ///清空数据库
  Future<int> clear() async {
    ///清空表
    String sql = "delete from $tab_name";
    int result = await DatabaseSqliteHelper.db.rawDelete(sql);

    ///自增归零
    String sql2 = "update sqlite_sequence SET seq = 0 where name = $tab_name";
    int result2 = await DatabaseSqliteHelper.db.rawUpdate(sql2);
    debugPrint("通知消息数据库清空结果$tag：" + result.toString() + result2.toString());

    return result;
  }
//
//
  //查询  更具客服Id获取相应的聊天记录select * from users order by id limit 10 offset 0;//offset代表从第几条记录“之后“开始查询，limit表明查询多少条结果
  Future<List<DataModel>>selectAllData() async {
    ///字母升序
    String sql =
        "select * from $tab_name order by _id asc";
    debugPrint("问题反馈数据库查询语句$tag：" + sql);
    List<Map<String, dynamic>> result = await DatabaseSqliteHelper.db.rawQuery(sql);
    debugPrint("问题反馈数据库查询结果$tag：" + result.toString());
    List<DataModel> friends = new List();
    for(int i = 0; i<result.length; i++){
      var element = result[i];
      DataModel friendModel = DataModel.fromMap(element);
      friends.add(friendModel);
    }

    return friends;
  }
//
//  //查询  更具客服Id获取相应的聊天记录select * from users order by id limit 10 offset 0;//offset代表从第几条记录“之后“开始查询，limit表明查询多少条结果
//  Future<int>selectOneData(String orderId) async {
//    ///字母升序
//    String sql =
//        "select * from $tab_name where orderId = ? order by _id asc";
//    debugPrint("问题反馈数据库查询语句$tag：" + sql);
//    List<Map<String, dynamic>> result = await DatabaseSqliteHelper.db.rawQuery(sql, [orderId]);
//    debugPrint("问题反馈数据库查询结果$tag：" + result.toString());
//    List<DataModel> friends = new List();
//    for(int i = 0; i<result.length; i++){
//      var element = result[i];
//      DataModel friendModel = DataModel.fromMap(element);
//      friends.add(friendModel);
//    }
//    return friends.length;
//  }
//
//
  //修改好友的某一条数据
  Future<dynamic>updateQuestionsOneParameter( String name,String name1,int age,int age1) async {
    String sql = "update $tab_name set name = ? , age = ? where name = '$name' and age = $age";
    var res = await DatabaseSqliteHelper.db.rawUpdate(sql, [name1,age1]);
    debugPrint("修改问题反馈某一条数据结果$tag：" + res.toString());
    return res;
  }

}
