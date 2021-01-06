import 'package:flutter/material.dart';

import '../../db/db.dart';
import '../../models/Right.dart';

class FourthRightPage extends StatefulWidget {
  @override
  FourthRightPageState createState() => new FourthRightPageState();
}

class FourthRightPageState extends State<FourthRightPage> with AutomaticKeepAliveClientMixin<FourthRightPage> {
  @override
  bool get wantKeepAlive => true;

  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration( hintText: '오른쪽 이름' ),
                    onSubmitted: _insertRightName,
                  ),
                ),
              ),

              Container(
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () { _insertRightName(_controller.text); }
                )
              )
            ]
          ),

          Expanded(
            child: SizedBox(
              child: FutureBuilder<List<Right>>(
                future: DB.instance.getRightName(),
                builder: (context, snapshot) {
                  if( snapshot.hasData ) {
                    return ListView.separated(
                      padding: const EdgeInsets.all(10.0),
                      separatorBuilder: (context, index) => Divider( color: Colors.black, ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text( snapshot.data[index].id.toString() ),
                          subtitle: Text( snapshot.data[index].name ),
                          trailing:
                            IconButton(
                              alignment: Alignment.center,
                              icon: Icon(Icons.delete),
                              onPressed: () async { _deleteRightName(snapshot.data[index].id); }
                            ),
                        );
                      },
                    );
                  }

                  else if( snapshot.hasError ) return Text('Oops!');
                  else return Center( child: CircularProgressIndicator() );
                },
              ),
            ),
          ),
        ]
      ),
    );
  }

  _deleteRightName(int id) { DB.instance.deleteRightName(id); setState(() {}); }
  _insertRightName(String name) { DB.instance.insertRightName(name); setState(() {}); }
}