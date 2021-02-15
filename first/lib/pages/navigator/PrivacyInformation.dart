import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';

import '../../db/User.dart';
import '../../models/User.dart';

class PrivacyInformation extends StatefulWidget {
  @override
  PrivacyInformationState createState() => new PrivacyInformationState();
}

class PrivacyInformationState extends State<PrivacyInformation> {
  List<bool> _genderSelected = [ false, false ];
  User _user = User();

  TextEditingController _nameController;
  List<TextEditingController> _birthController = [ TextEditingController(), TextEditingController(), TextEditingController() ];
  FocusNode _fn1 = FocusNode(), _fn2 = FocusNode(), _fn3 = FocusNode();


  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    _user = await getPrivacyInformationData();

    _nameController = TextEditingController(text: _user.name);

    _birthController[0] = TextEditingController(text: _user.year);
    _birthController[1] = TextEditingController(text: _user.month);
    _birthController[2] = TextEditingController(text: _user.day);

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
                      controller: _nameController,
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
                onTap: () { _changeFocus(context, _fn1); },
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '생년월일',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0
                        )
                      )
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 5.0, left: 10.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 40,
                            child: TextField(
                              controller: _birthController[0],
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(4),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              focusNode: _fn1,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              onChanged: (String year) {
                                if( year.length == 4 ) _changeFocus(context, _fn2);
                              },
                            ),
                          ),

                          Text(' 년 '),

                          Container(
                            width: 25,
                            child: TextField(
                              controller: _birthController[1],
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              focusNode: _fn2,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              onChanged: (String month) {
                                if( month.length == 2 ) _changeFocus(context, _fn3);
                                if( month.length == 0 ) _changeFocus(context, _fn1);
                              },
                            ),
                          ),

                          Text(' 월 '),

                          Container(
                            width: 25,
                            child: TextField(
                              controller: _birthController[2],
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              cursorColor: Colors.black,
                              focusNode: _fn3,
                              decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              onChanged: (String day) {
                                if( day.length == 0 ) _changeFocus(context, _fn2);
                              },
                              onEditingComplete: () {
                                _upsertUserData();
                              },
                            ),
                          ),

                          Text(' 일 '),
                        ]
                      )
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

  void _changeFocus(BuildContext context, FocusNode _fn) {
    FocusScope.of(context).requestFocus(_fn);
    setState(() {});
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

  Future<void> _upsertUserData() async { await upsertPrivacyInformation(_user, _birthController); }
}