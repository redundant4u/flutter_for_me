import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/Users.dart';
import '../../db/db.dart';

class PrivacyInformation extends StatefulWidget {
  @override
  PrivacyInformationState createState() => new PrivacyInformationState();
}

class PrivacyInformationState extends State<PrivacyInformation> {
  String _birthDate;
  List<bool> _genderSelected = [ true, false ];

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('개인정보', style: TextStyle(color: Colors.black))
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
              width: 350,
              height: 100,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '이름',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0
                      )
                    )
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 5.0, left: 10.0),
                    child: TextField(
                      controller: _controller,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    )
                  )
                ],
              ),
            ),
            
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(bottom: 20.0),
              width: 350,
              height: 100,
              child: InkWell(
                onTap: () { _selectDate(context); },
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '생년월일',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18.0
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: 18.0, left: 10.0),
                      child: Text(
                        _birthDate ?? '',
                        style: TextStyle(
                          fontSize: 18.0
                        )
                      ),
                    )
                  ],
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10.0),
              width: 350,
              height: 100,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '성별',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18.0
                      )
                    )
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 8.0, left: 10.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return ToggleButtons(
                          constraints: BoxConstraints.expand(
                            width: (constraints.maxWidth - 10.0) / 2,
                            height: 40.0
                          ),
                          children: <Widget>[
                            Text('남'),
                            Text('여'),
                          ],
                          onPressed: (int index) { _selectGender(index); },
                          isSelected: _genderSelected,
                        );
                      },
                    )
                  ),
                ],
              ),
            ),

            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(top: 10.0, right: 40.0),
              child: MaterialButton(
                height: 40.0,
                color: Colors.grey,
                child: Text('저장'),
                onPressed: () async {
                  Users users = Users(
                    name: _controller.text,
                    gender: _genderSelected,
                    birth: _birthDate
                  );

                  await DB.instance.insertPrivacyInformation(users);
                },
              )
            ),
          ]
        )
      )
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse('1997-09-11'),
      firstDate: DateTime(1920, 1),
      lastDate: DateTime(2020, 1)
    );

    if( picked != null ) {
      setState(() { _birthDate = DateFormat('yyyy-MM-dd').format(picked).toString(); });
    }
  }

  void _selectGender(int index) {
     if( index == 0 ) {
        _genderSelected[0] = true;
        _genderSelected[1] = false;
      }

     else {
        _genderSelected[0] = false;
        _genderSelected[1] = true;
      }

      setState(() {});
  }
}