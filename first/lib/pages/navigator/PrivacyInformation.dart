import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../db/User.dart';
import '../../models/User.dart';

class PrivacyInformation extends StatefulWidget {
  @override
  PrivacyInformationState createState() => new PrivacyInformationState();
}

class PrivacyInformationState extends State<PrivacyInformation> {
  List<bool> _genderSelected = [ false, false ];
  User _user = User();

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    _user = await getPrivacyInformationData();

    _controller = TextEditingController(text: _user.name);
    _user.male   == 1 ? _genderSelected[0] = true : _genderSelected[0] = false;
    _user.female == 1 ? _genderSelected[1] = true : _genderSelected[1] = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      onSubmitted: (name) async {
                        _user.name = name;
                        _upsertUserData();
                      },
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
                        _user.birth ?? '',
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
                          onPressed: (int index) {
                            _selectGender(index);

                            if( _genderSelected[0] ) { _user.male = 1; _user.female = 0; }
                            else                     { _user.male = 0; _user.female = 1; }
                            _upsertUserData();
                          },
                          isSelected: _genderSelected,
                        );
                      },
                    )
                  ),
                ],
              ),
            ),
          ]
        )
      )
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    if( _user.birth == null ) _user.birth = '1997-09-11';

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(_user.birth),
      firstDate: DateTime(1920, 1),
      lastDate: DateTime(2020, 1)
    );

    if( picked != null ) {
      setState(() { _user.birth = DateFormat('yyyy-MM-dd').format(picked).toString(); });
      _upsertUserData();
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

  Future<void> _upsertUserData() async { await upsertPrivacyInformation(_user); }
}