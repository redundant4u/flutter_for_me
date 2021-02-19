import 'package:flutter/material.dart';

import '../../models/User.dart';
import '../../db/User.dart';

class DBtest extends StatefulWidget {
  @override
  DBtestState createState() => new DBtestState();
}

class DBtestState extends State<DBtest> {
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
              child: FutureBuilder<List<User>>(
                future: getUserList(),
                builder: (context, snapshot) {
                  if( snapshot.hasData ) {
                    return ListView.separated(
                      padding: const EdgeInsets.all(10.0),
                      separatorBuilder: (context, index) => Divider( color: Colors.black, ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text( snapshot.data[index].id.toString() ),
                          subtitle: Text( snapshot.data[index].toMap().toString() ),
                          trailing:
                            IconButton(
                              alignment: Alignment.center,
                              icon: Icon(Icons.delete),
                              onPressed: () async { _deleteUser(); }
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

  _deleteUser() { deleteUser(); setState(() {}); }
  // _insertLeftName(String name) { DB.instance.insertLeftName(name); setState(() {}); }
}
