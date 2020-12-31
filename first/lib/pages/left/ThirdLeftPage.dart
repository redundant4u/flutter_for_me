import 'package:flutter/material.dart';

import '../../db/db.dart';
import '../../models/Left.dart';

class ThirdLeftPage extends StatefulWidget {
  @override
  ThirdLeftPageState createState() => new ThirdLeftPageState();
}

class ThirdLeftPageState extends State<ThirdLeftPage> with AutomaticKeepAliveClientMixin<ThirdLeftPage> {
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
                    decoration: InputDecoration( hintText: '왼쪽 이름' ),
                    onSubmitted: _insertLeftName,
                  ),
                ),
              ),

              Container(
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () { _insertLeftName(_controller.text); }
                )
              )
            ]
          ),

          Expanded(
            child: SizedBox(
              child: FutureBuilder<List<Left>>(
                future: DB.instance.getLeftName(),
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
                              onPressed: () async { _deleteLeftName(snapshot.data[index].id); }
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

  _deleteLeftName(int id) { DB.instance.deleteLeftName(id); setState(() {}); }
  _insertLeftName(String name) { DB.instance.insertLeftName(name); setState(() {}); }
}