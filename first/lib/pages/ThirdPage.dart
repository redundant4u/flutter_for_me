import 'package:flutter/material.dart';

import '../db/db.dart';
import '../models/Left.dart';
import './ThirdGraphPage.dart';

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Left>>(
      future: DB.instance.getGraphDate(),
      builder: (context, snapshot) {
        if( snapshot.hasData ) {
          return ListView.separated(
            padding: EdgeInsets.all(10.0),
            separatorBuilder: (context, index) => Divider(color: Color(0xFFF0AD74)),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext contxt, int index) {
              return ListTile(
                title: Text(snapshot.data[index].date),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    ThirdGraphPage(snapshot.data[index].id)
                  ));
                },
              );
            },
          );
        }

        else if( snapshot.hasError ) return Text('Oops!');
        else { print('no data'); return Center(child: CircularProgressIndicator() ); }
      }
    );
  }
}