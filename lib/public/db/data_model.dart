
import 'package:flutter/foundation.dart';

class DataModel {
  String name;
  int age;

  DataModel(
      {Key key,
        @required this.name,
        @required this.age,
      });

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = name;
    map['age'] = age;
    return map;
  }

  static DataModel fromMap(Map<String, dynamic> map) {
    DataModel model = new DataModel();
    model.name = map['name'];
    model.age = map['age'];
    return model;
  }

  static List<DataModel> fromMapList(dynamic mapList) {
    List<DataModel> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['name'] = name;
    map['age'] = age;

    return map;
  }
}
