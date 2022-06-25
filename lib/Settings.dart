import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_tessy_app/constants.dart';
import 'package:main_tessy_app/database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String message = "";
  DatabaseHelper databaseHelper;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String email;
  String password, _dob, username, _dateValue;

  TextEditingController _datecontroller = TextEditingController();
  DateTime dateTime;
  String userDetails = "userDetails";
  List<String> userDetailsList;
  TextEditingController userNameCtrl = new TextEditingController();
  TextEditingController dobCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();

  _buildDate() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        onTap: () {
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1910),
                  lastDate: DateTime(2050))
              .then((date) {
            final DateFormat formatter = DateFormat('yyyy-MM-dd');
            final String formatted = formatter.format(date);
            // final now = DateTime.now();
            // final tt = DateTime(2020,09,14);
            //  if(tt.day == date.day){
            //    print("ppp");
            //  }

            setState(() {
              _datecontroller.text = formatted;
            });
          });
        },
        readOnly: true,
        onChanged: (value) {
          value = _dob;
        },
        controller: _datecontroller,
        onSaved: (value) {
          _dob = value;
        },
        validator: (value) {
          if (value.length < 3) {
            return "Please input your date of birth";
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.date_range,
              color: mainColor,
            ),
            labelText: "Date Of Birth"),
      ),
    );
  }

  @override
  void initState() {
    databaseHelper = DatabaseHelper.instance;
    getUsers();
    // TODO: implement initState

    super.initState();
  }

  bool isLoading = false;
  void cancelLoading() {
    if (isLoading) {
      Timer(Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  getUsers() async {
    loadData().then((val) {
      if (val == null) {
// error
      } else {
        setState(() {
          userDetailsList = val;
          userNameCtrl.text = userDetailsList[0];
          dobCtrl.text = userDetailsList[2];
          emailCtrl.text = userDetailsList[3];
          passwordCtrl.text = userDetailsList[1];
          print(userDetailsList);
        });

///// pint
      }
    });
  }

  //////////////////load data from sharepreference
  Future<List> loadData() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getStringList(userDetails);
  }

  Future<bool> savaData(
      {String username,
      String password,
      String dob,
      String email,
      String i}) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    // print(oka);

    return await preference
        .setStringList(userDetails, [username, password, dob, email]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0.0,
        title: Text(
          "Profile Settings",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width / 15),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              color: mainColor,
              height: 100,
            ),
            Container(
                height: 1000,
                width: MediaQuery.of(context).size.width,
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 0.0),
                child: Card(
                    child: Container(
                        height: MediaQuery.of(context).size.height / 11,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildContainer(),
                          ],
                        )))),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(color: Colors.white),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildUserName(),
                  _buildDate(),
                  _buildEmail(),
                  _buildPassword(),
                  // _buildForgetPasswordButton(),
                  _buildLoginButton(),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),

                  isLoading ? Text("Loading...") : Text(""),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                  ),
                  Text(message)
                  //  _buildRow(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildEmail() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: emailCtrl,
        onSaved: (value) {
          email = value;
        },
        validator: (value) {
          bool validEmail = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value);

          if (value.length < 3 || !validEmail) {
            return "Invalid email addrress";
          }
        },
        onChanged: (value) {
          email = value;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
              color: mainColor,
            ),
            labelText: "Email"),
      ),
    );
  }

  _buildPassword() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        //obscureText: true,
        controller: passwordCtrl,
        onSaved: (value) {
          password = value;
        },
        validator: (value) {
          if (value.length < 5) {
            return "Password must be at least 5 characters";
          }
        },
        onChanged: (value) {
          password = value;
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: mainColor,
            ),
            labelText: "Password"),
      ),
    );
  }

  _buildUserName() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        onSaved: (value) {
          username = value;
        },
        controller: userNameCtrl,
        validator: (value) {
          if (value.length < 3) {
            return "Username must be at least 3 characters";
          }
        },
        onChanged: (value) {
          password = value;
        },
        readOnly: true,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: mainColor,
            ),
            labelText: "User Name"),
      ),
    );
  }

  // _buildForgetPasswordButton() {

  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: <Widget>[
  //       FlatButton(
  //         onPressed: (){},
  //         child: Text("Forget Password"),
  //       ),

  //   ],);
  // }

  _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * MediaQuery.of(context).size.height / 20,
          width: 5 * MediaQuery.of(context).size.width / 10,
          margin: EdgeInsets.only(top: 10),
          child: RaisedButton(
            color: mainColor,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Text(
              "Update Profile",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              //print(userDetailsList[4]);

              if (_formKey.currentState.validate()) {
                setState(() {
                  message = "";
                  isLoading = true;
                });
                cancelLoading();
                _formKey.currentState.save();
                Database dbClient = await DatabaseHelper.instance.database;

                var result = await dbClient.query("users",
                    columns: ['username'],
                    where: "username = ?",
                    whereArgs: [username]);

                if (!result.isEmpty) {
                  var id = userDetailsList[0];

                  int i = await databaseHelper.update({
                    "username": username,
                    "password": password,
                    "email": email,
                    "DOB": _dob
                  });

                  if (i > 0) {
                    bool isSaved = await savaData(
                        username: username,
                        password: password,
                        dob: _dob,
                        email: email,
                        i: i.toString());
                    print(i);

                    if (isSaved) {
                      setState(() {
                        message = "Successfuly Updated";
                      });
                    }

                    //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext)=>LoginPage()));

                  } else {
                    setState(() {
                      message = "Failed: An error occored";
                    });
                  }
                }
                ;
              }
            },
          ),
        )
      ],
    );
  }
}
