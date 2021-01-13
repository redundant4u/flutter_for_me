import 'package:flutter/material.dart';

import '../db/db.dart';
import '../models/Left.dart';
// import './left/FourthLeftPage.dart';
// import './right/FourthRightPage.dart';

class FourthPage extends StatefulWidget {
  @override
  FourthPageState createState() => new FourthPageState();
}

class FourthPageState extends State<FourthPage> {
  final TextEditingController _controller = TextEditingController();

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration( hintText: '왼쪽 이름' ),
                  // onSubmitted: _insertLeftName,
                ),
              ),
            ),

            Container(
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () { } // _insertLeftName(_controller.text); }
              )
            )
          ]
        ),

        Expanded(
          child: SizedBox(
            child: FutureBuilder<List<Left>>(
              future: DB.instance.getLeftWholeData(),
              builder: (context, snapshot) {
                if( snapshot.hasData ) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(10.0),
                    separatorBuilder: (context, index) => Divider( color: Colors.black, ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text( snapshot.data[index].id.toString() ),
                        subtitle: Text(
                          "${snapshot.data[index].dB1.toString()} ${snapshot.data[index].dB2.toString()} "
                          "${snapshot.data[index].dB3.toString()} ${snapshot.data[index].dB4.toString()} "
                          "${snapshot.data[index].dB5.toString()} ${snapshot.data[index].dB6.toString()} "
                          "${snapshot.data[index].dB7.toString()}"
                        ),
                        trailing:
                          IconButton(
                            alignment: Alignment.center,
                            icon: Icon(Icons.delete),
                            onPressed: () async { _deleteLeftData(snapshot.data[index].id); }
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
    );
  }

  _deleteLeftData(int id) { DB.instance.deleteLeftData(id); setState(() {}); }
  // _insertLeftName(String name) { DB.instance.insertLeftName(name); setState(() {}); }
  // Widget _leftPage() { return FourthLeftPage(); }
  // Widget _rightPage() { return FourthRightPage(); }
}