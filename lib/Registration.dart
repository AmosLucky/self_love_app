import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:main_tessy_app/LoginPage.dart';
import 'package:main_tessy_app/UserDashbord.dart';
import 'package:main_tessy_app/database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'constants.dart';
import 'package:intl/intl.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<Registration> {
  String message = "";
  bool _switchValue = true;
  DatabaseHelper databaseHelper;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String email;
  String password, _dob, username, _dateValue;

  TextEditingController _datecontroller = TextEditingController();
  DateTime dateTime;
  List<String> userDetailsList;
  String userDetails = "userDetails";
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

  /////////////////////save record in sharedPreference
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

  //////////////////load data from sharepreference
  Future<List> loadData() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getStringList(userDetails);
  }

  check() async {
    loadData().then((val) {
      if (val == null) {
        print("Not Registered");
      } else {
        setState(() {
          userDetailsList = val;
        });

        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext) => UserDashboard(
                  userDetailsList: userDetailsList,
                )));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD8DBD7),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(70),
                        bottomRight: const Radius.circular(70))),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                //      CupertinoSwitch(
                //   value: _switchValue,
                //   onChanged: (value) {
                //     setState(() {
                //       //_switchValue = value;
                //     });
                //   },
                // ),
                _buildContainer(),
                _buildSigningButton()
              ],
            )
          ],
        ),
      ),
    );

    //);
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Self Love",
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 25,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _buildContainer() {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(color: Colors.white),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Registration",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        fontWeight: FontWeight.bold,
                        //color: Colors.white
                      ),
                    ),
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
      ),
    );
  }

  _buildEmail() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
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
        obscureText: true,
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
        validator: (value) {
          if (value.length < 3) {
            return "Username must be at least 3 characters";
          }
        },
        onChanged: (value) {
          password = value;
        },
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
              "Register",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 40,
                  letterSpacing: 1.5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
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
                  setState(() {
                    message = "A user with this username already exists";
                  });
                } else {
                  int i = await databaseHelper.insert({
                    "username": username,
                    "password": password,
                    "email": email,
                    "DOB": _dob
                  });

                  if (i > 0) {
                    setState(() {
                      message = "Successuly Registred";
                    });

                    Database dbClient = await databaseHelper.database;

                    var result = await dbClient.query("users",
                        columns: ['username', 'password', 'email', 'DOB', 'id'],
                        where: "username = ? AND password = ?",
                        whereArgs: [username, password]);
                    if (!result.isEmpty) {
                      print("gooo");
                      var username = result[0]['username'];
                      var password = result[0]['password'];
                      var dob = result[0]['dob'];
                      var email = result[0]['email'];
                      var id = result[0]['id'];

                      /// print("details  :"+ dob);

                      bool isSaved = await savaData(
                          username: username,
                          password: password,
                          dob: dob,
                          email: email,
                          i: id.toString());
                      if (isSaved) {
                        /////// to dashboard ////
                        check();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext) => UserDashboard()));
                      } else {
                        print("NOT SAVED");
                      }
                    } else {
                      setState(() {
                        message = "Failed: An error occored";
                      });
                    }
                  }
                  ;
                }
              }
            },
          ),
        )
      ],
    );
  }

  Widget _buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(
            "- OR -",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  _buildSigningButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: FlatButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext) => LoginPage()));
            },
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Already have an account?",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: MediaQuery.of(context).size.height / 40,
                        color: Colors.black)),
                TextSpan(
                    text: "  Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 40,
                        color: mainColor)),
              ]),
            ),
          ),
        )
      ],
    );
  }
}
