import 'package:flutter/material.dart';

import '../../models/Graph.dart';
import '../../db/Graph.dart';

class DBtest2 extends StatefulWidget {
  @override
  DBtest2State createState() => new DBtest2State();
}

class DBtest2State extends State<DBtest2> {
  final TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('DB 보기', style: TextStyle(color: Colors.black))
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              child: FutureBuilder<List<double>>(
                future: getLeftGraphData(),
                builder: (context, snapshot) {
                  if( snapshot.hasData ) {
                    return ListView.separated(
                      padding: const EdgeInsets.all(10.0),
                      separatorBuilder: (context, index) => Divider( color: Colors.black, ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text( snapshot.data[index].toString() ),
                          // subtitle: Text( snapshot.data[index].toString() ),
                          trailing:
                            IconButton(
                              alignment: Alignment.center,
                              icon: Icon(Icons.delete),
                              onPressed: () async { _deleteGraph(index); }
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

  _deleteGraph(int index) { deleteGraphData(index); setState(() {}); }
  // _insertLeftName(String name) { DB.instance.insertLeftName(name); setState(() {}); }
}
