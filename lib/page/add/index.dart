import 'package:demo/public/db/data_model.dart';
import 'package:demo/public/db/data_sqlite.dart';
import 'package:demo/public/login_input.dart';
import 'package:demo/public/rbtn.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController namecon = new TextEditingController();
  TextEditingController agecon = new TextEditingController();
  List<DataModel> allmsg = [];
  int index1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getmsg();
  }

  _getmsg() {
    DataSqlite.instance.selectAllData().then((value) {
      setState(() {
        allmsg = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('新增'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: LoginInput(
                controller: namecon,
                tishiyu1: '请输入用户名',
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: LoginInput(
                controller: agecon,
                tishiyu1: '请输入年龄',
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                children: <Widget>[
                  Rbtn(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 50,
                    color: 0xff0000ff,
                    text: '添加',
                    needborder: false,
                    onTap: () {
                      _add();
                    },
                  ),
                  Rbtn(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 50,
                    color: 0xff0000ff,
                    text: '编辑',
                    needborder: false,
                    onTap: () {
                      _edit(index1);
                    },
                  ),
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: allmsg.length,
                itemBuilder: (item, index) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(allmsg[index].name),
                          subtitle: Text(allmsg[index].age.toString()),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        top: 20,
                        child: FlatButton(
                          color: Colors.red,
                          child: InkWell(
                            onTap: () {
                              _del(index);
                            },
                            child: Text(
                              '删除',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        top: 0,
                        child: FlatButton(
                          color: Colors.red,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                index1 = index;
                                namecon.text = allmsg[index].name;
                                agecon.text = allmsg[index].age.toString();
                              });
                            },
                            child: Text(
                              '编辑',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }

  _add() {
    DataSqlite.instance
        .insert(DataModel(name: namecon.text, age: int.parse(agecon.text)))
        .then((value) async {
      print('所有数据=====${DataSqlite.instance.selectAllData().toString()}');
      allmsg = await DataSqlite.instance.selectAllData();
      namecon.text = '';
      agecon.text = '';
      setState(() {});
    });
  }

  _del(index) {
    DataSqlite.instance
        .delete(allmsg[index].name, allmsg[index].age)
        .then((value) {
      print('是否成功=====${value}');
      if (value == 1) {
        Fluttertoast.showToast(msg: '删除成功');
        setState(() {
          allmsg.removeAt(index);
        });
      } else {
        Fluttertoast.showToast(msg: '删除失败');
      }
    });
  }

  _edit(index) {
    DataSqlite.instance
        .updateQuestionsOneParameter(allmsg[index].name, namecon.text,
            allmsg[index].age, int.parse(agecon.text))
        .then((value) {
      if (value == 1) {
        Fluttertoast.showToast(msg: '编辑成功');
        setState(() {
          allmsg[index].name = namecon.text;
          allmsg[index].age = int.parse(agecon.text);
          namecon.text = '';
          agecon.text = '';
        });
      } else {
        Fluttertoast.showToast(msg: '编辑失败');
      }
    });
  }
}
