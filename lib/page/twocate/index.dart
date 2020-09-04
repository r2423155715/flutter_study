import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TwoCatePage extends StatefulWidget {
  @override
  _TwoCatePageState createState() => _TwoCatePageState();
}

class _TwoCatePageState extends State<TwoCatePage> {

  List imglist=[
    'https://cdn.pixabay.com/photo/2020/08/21/08/46/african-5505598__340.jpg',
    'https://cdn.pixabay.com/photo/2020/06/26/00/25/summer-5341326__340.jpg',
    'https://cdn.pixabay.com/photo/2020/08/25/18/29/workplace-5517762__340.jpg',
    'https://cdn.pixabay.com/photo/2020/07/25/06/41/mountains-5435903__340.jpg',
    'https://cdn.pixabay.com/photo/2020/05/31/15/31/migratory-birds-5242969__340.jpg',
    'https://cdn.pixabay.com/photo/2020/08/19/05/53/asleep-5500058__340.jpg',
    'https://cdn.pixabay.com/photo/2020/04/23/19/15/face-5083690__340.jpg',
    'https://cdn.pixabay.com/photo/2020/03/08/11/22/cat-4912213__340.jpg'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第er个'),
      ),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: imglist.length??0,
        itemBuilder: (BuildContext context, int index) => new Container(
            color: Colors.green,
            child: Image.network(imglist[index],fit: BoxFit.cover,)),
        staggeredTileBuilder: (int index) =>
        new StaggeredTile.count(2, index.isEven ? 3 : 1),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}
