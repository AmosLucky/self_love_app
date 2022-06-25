import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:main_tessy_app/About.dart';
import 'package:main_tessy_app/GetHelp.dart';
import 'package:main_tessy_app/LoginPage.dart';
import 'package:main_tessy_app/LoveQuotes.dart';
import 'package:main_tessy_app/Settings.dart';
import 'package:main_tessy_app/constants.dart';
import 'package:main_tessy_app/database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'package:url_launcher/url_launcher.dart';

class UserDashboard extends StatefulWidget {
  List<String> userDetailsList;
  UserDashboard({this.userDetailsList});
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  DatabaseHelper databaseHelper;
  String quoteOfTheDay = "";
  int randomNumber;
  String userDetails = "userDetails";
  List<String> userDetailsList;

  logout() async {
    //String value = _controller.text;
    SharedPreferences preference = await SharedPreferences.getInstance();
    // print(oka);
    String userDetails = "userDetails";

    await preference.remove(userDetails);
    setState(() {
      //isReg = false;
    });

    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext) => LoginPage()));
  }

  @override
  Future initState() {
    databaseHelper = DatabaseHelper();
    getDailyQoutes();

    // print(widget.userDetailsList);
    generateRand();
    //// load user//
    getUsers();
    // TODO: implement initState
    super.initState();
  }
  Future loadDay() async{
    SharedPreferences preference = await SharedPreferences.getInstance();
   return  preference.getInt("day");
    
  }

  getDailyQoutes() async {
    var id;
    loadDay().then((value) {
      id =value;

    });
    Database dbClient = await databaseHelper.database;
    var result =
        await dbClient.query("daily_quotes", where: "id = ?", whereArgs: [id]);

    if (!result.isEmpty) {
      setState(() {
        quoteOfTheDay = result[0]["quote"];
      });
    } else {
      setState(() {
        quoteOfTheDay = "No qoute today";
      });
    }
  }

  List<String> images = [
    'background1',
    'background2',
    'background3',
    'background4',
    'background5',
    'background6',
    'background7',
    'background8',
    'background9',
    'background10'
  ];
  generateRand() {
    Random random = new Random();
    var rand = random.nextInt(10);
    setState(() {
      randomNumber = rand;
    });
  }

  getUsers() async {
    loadData().then((val) {
      if (val == null) {
// error
      } else {
        setState(() {
          userDetailsList = val;
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
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: mainColor,
        action: SnackBarAction(label: "YES",onPressed: (){
          SystemNavigator.pop();
        },),
      content: Text("Do you want to Exit this App?"),
    ));
      },
      child: Scaffold(
        key: _scaffoldKey,
        
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  
                  decoration: BoxDecoration(color: mainColor),
                  accountName: Text(userDetailsList[0]),
                  accountEmail: Text(userDetailsList[3]),
                  currentAccountPicture: Material(
                      shape: StadiumBorder(),
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/logo.jpg"),
                      )),
                ),

                ////////////////////otheres////
                InkWell(
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: mainColor,
                    ),
                    title: Text("Home"),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext) => UserDashboard()));
                  },
                ),

                ///////////////////////
                InkWell(
                  child: ListTile(
                    leading: Icon(
                      Icons.favorite,
                      color: mainColor,
                    ),
                    title: Text("Self Love Quotes"),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext) => LoveQuotePage()));
                  },
                ),
                //////////////////////
                InkWell(
                  child: ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: mainColor,
                    ),
                    title: Text("Profile Settings"),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext) => Settings()));
                  },
                ),
                ///////////////
                InkWell(
                  child: ListTile(
                    leading: Icon(
                      Icons.share,
                      color: mainColor,
                    ),
                    title: Text("Share App"),
                  ),
                  onTap: () async {
                    var message =
                        '''Download Tessy Love App from Playstore, it is the best Self Love App. Use the Link below''';
                    var response =
                        await FlutterShareMe().shareToSystem(msg: message);
                    if (response == 'success') {
                      print('navigate success');
                    }
                  },
                ),
                ///////////
                InkWell(
                  child: ListTile(
                    leading: Icon(
                      Icons.people,
                      color: mainColor,
                    ),
                    title: Text("About Us"),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext) => About()));
                  },
                ),
                InkWell(
                  child: ListTile(
                    leading: Icon(
                      Icons.help_outline,
                      color: mainColor,
                    ),
                    title: Text("Get Help"),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext) => GetHelp()));
                  },
                ),
                
                InkWell(
                  child: ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: mainColor,
                    ),
                    title: Text("Close App"),
                  ),
                  onTap: () {
                    SystemNavigator.pop();
                  },
                ),

                /////////////////footer///////////////
                // Expanded(),
                Container(
                    child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Column(
                          children: <Widget>[
                            Divider(),
                            InkWell(
                              child: ListTile(
                                  leading: Icon(
                                    Icons.call,
                                    color: mainColor,
                                  ),
                                  title: Text('Designed by Lucky Amos')),
                              onTap: () async {
                               var url  = "https://web.facebook.com/amos.chibex.lucky";
                                if (await canLaunch(url)) {
                                  await launch(
                                    url,
                                    forceSafariVC: false,
                                    forceWebView: false,
                                    headers: <String, String>{
                                      'my_header_key': 'my_header_value'
                                    },
                                  );
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            ),
                          ],
                        ))),

                //Drawer
              ],
            ),
          ),
          appBar: AppBar(
            actions: <Widget>[
             Container(
               margin: EdgeInsets.only(right:10,top: 10),
               child: InkWell(child: Column(
                 children: <Widget>[
                   Icon(Icons.power_settings_new),
                   Text("Logout",style: TextStyle(fontSize: 12),)
                 ],
               ),
               onTap: (){
                 logout();

               },
               ),
               )
            ],
            backgroundColor: mainColor,
            elevation: 0.0,
            title: Text(
              "Self Love",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width / 15),
            ),
            centerTitle: true,
          ),

          //backgroundColor: mainColor,
          body: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: mainColor,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: MediaQuery.of(context).size.width / 8.5),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/" +
                                    images[randomNumber] +
                                    ".jpg"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(10))),
                          height: MediaQuery.of(context).size.width / 2.1,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                              child: Text(quoteOfTheDay,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: MediaQuery.of(context).size.width / 18,
                                      fontWeight: FontWeight.bold))),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "Daily Quote for "+ userDetailsList[0],
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width / 27,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                ),
              ),

              ///////////////////////////////////////////////////////////////

              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 2.6),

                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                // padding: EdgeInsets.symmetric(horizontal:20),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: (MediaQuery.of(context).size.width / 300),
                  children: <Widget>[
                    ///////////////////////////////// one row ///////////////////////
                    /////////////////////Right //////////////////

                    Container(
                      //padding: EdgeInsets.only(left: 10),
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(right: 5, left: 10),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(
                          const Radius.circular(10),
                        ),
                        child: MaterialButton(
                          splashColor: mainColor,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext) => LoveQuotePage()));
                          },
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.all(
                                      const Radius.circular(50),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  )),
                              Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Self Love Quotes",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Indies'),
                                  )),
                            ],
                          )),
                        ),
                      ),
                    ),

                    //////////////////////////////// left//////////////////

                    Container(
                      margin: EdgeInsets.only(left: 5, right: 10),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(
                          const Radius.circular(10),
                        ),
                        child: MaterialButton(
                          splashColor: mainColor,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext) => Settings()));
                          },
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.all(
                                      const Radius.circular(50),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                  )),
                              Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Profile Settings",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Indies'),
                                  )),
                            ],
                          )),
                        ),
                      ),
                    ),
                    ///////////////////////////////////////////// one row////////////////////////////////
                    ///

                    ///////////////////////////////// one row ///////////////////////
                    /////////////////////Right //////////////////

                    Container(
                      margin: EdgeInsets.only(right: 5, top: 10, left: 10),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(
                          const Radius.circular(10),
                        ),
                        child: MaterialButton(
                          splashColor: mainColor,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext) => About()));
                          },
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.all(
                                      const Radius.circular(50),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.people,
                                    color: Colors.white,
                                  )),
                              Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "About Us",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Indies'),
                                  )),
                            ],
                          )),
                        ),
                      ),
                    ),

                    //////////////////////////////// left//////////////////

                    Container(
                      margin: EdgeInsets.only(left: 5, top: 10, right: 10),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(
                          const Radius.circular(10),
                        ),
                        child: MaterialButton(
                          splashColor: mainColor,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext) => GetHelp()));
                          },
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: mainColor,
                                    borderRadius: BorderRadius.all(
                                      const Radius.circular(50),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.help_outline,
                                    color: Colors.white,
                                  )),
                              Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Get Help",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Indies'),
                                  )),
                            ],
                          )),
                        ),
                      ),
                    ),
                    ///////////////////////////////////////////// one row////////////////////////////////
                  ],
                ),
              ),
            ],
          ) //),
          ),
    );
  }
}
