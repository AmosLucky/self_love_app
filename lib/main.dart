import 'dart:async';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:main_tessy_app/LoginPage.dart';
import 'package:main_tessy_app/SingleBirthdayQuote.dart';
import 'package:main_tessy_app/UserDashbord.dart';
import 'package:main_tessy_app/database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';

import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Georgia',
        primarySwatch: Colors.purple,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final today = DateTime.now();
  String userDetails = "userDetails";
  List<String> userDetailsList;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  DatabaseHelper _databaseHelper;
  String quoteOfTheDay = "daily";
  String birthDayQUote = "Birthday";

  ////////////////////// get dailyquote/////////////
  ////////////////////////// getDailyQuotes////////////
  Future<void> getDailyQoutes() async {
    var id;
    loadDay().then((value) {
      id = value;
    });
    Database dbClient = await _databaseHelper.database;
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
    // print(quoteOfTheDay);
    _repeatNotification();
  }

  ///
  ///
  ///

  ///
  ///

  /////////////////////save record in sharedPreference

  check() async {
    loadData().then((val) {
      if (val == null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext) => LoginPage(),
                fullscreenDialog: true));
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
  void initState() {
    _databaseHelper = new DatabaseHelper();

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    var androidInitialize = AndroidInitializationSettings("logo");
    var iOSinitialize = IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSinitialize);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelected);

    Timer(Duration(seconds: 4), () {
      check();
    });

    updateToday();

    getDailyQoutes();
    getBirtDayQuote();

    // TODO: implement initState
    super.initState();
  }
  ////////////////set//////

  //////////////////load data from sharepreference
  Future loadBirthday() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString("shown");
  }

  Future<List> loadData() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getStringList(userDetails);
  }

  Future loadDate() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString("date");
  }

  Future loadDay() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getInt("day");
  }

  ////////////// sheduled ////////////////// Notification
  Future<void> _repeatNotification() async {
    var androidDetails = new AndroidNotificationDetails("id", "channel",
        importance: Importance.defaultImportance,
        color: Colors.purple,
        playSound: true,
        styleInformation: DefaultStyleInformation(true, true));
    var iosDetails = new IOSNotificationDetails();
    var generalDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    //var shedul = DateTime.now().add(Duration(seconds: 5));
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      quoteOfTheDay,
      "Click here to recieve the next day quote",
      Time(12, 0, 0),
      generalDetails,
    );
  }

  updateToday() {
    String dateString = today.day.toString() + today.year.toString();
    var newDay;

    loadDate().then((value) {
      print(value);
      if (value != null) {
        if (dateString != value) {
          _databaseHelper.saveDate(dateString);
          loadDay().then((value) {
            // print(value);
            if (value < 307) {
              newDay = value + 1;
            } else {
              newDay = 1;
            }
            _databaseHelper.saveDay(newDay);
          });
        } else {
          // print("==");
        }
      }
    });
  }

  getUsersDateOfBirth() async {
    var dbClient = await _databaseHelper.database;
    var result = await dbClient.query("users");

    checkAndShow(String shown, var result) {
      for (var i = 0; i < result.length; i++) {
        if (result[i]["DOB"] == today.toString().substring(0, 10)) {
          // print("ooooooooooo");

          if (shown == "false") {
            //  print("ooooooooooo99");
            _birthdayNotification();
            _databaseHelper.showBirthDayQuote("true");
          }
        } else {
          _databaseHelper.showBirthDayQuote("false");
        }
      }
    }

    loadBirthday().then((value) => {
          print(value),
          checkAndShow(value, result),
        });
  }

  //////////////////////////////
  Future<void> _birthdayNotification() async {
    var androidDetails = new AndroidNotificationDetails("id", "channel",
        importance: Importance.defaultImportance,
        color: Colors.purple,
        playSound: true,
        styleInformation: DefaultStyleInformation(true, true));
    var iosDetails = new IOSNotificationDetails();
    var generalDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    //var shedul = DateTime.now().add(Duration(seconds: 5));
    await flutterLocalNotificationsPlugin.show(
        0, birthDayQUote, "Happy BirthDay", generalDetails,
        payload: "task");
  }

  Future<void> getBirtDayQuote() async {
    Random random = new Random();
    var id = random.nextInt(100);
    Database dbClient = await _databaseHelper.database;
    var result = await dbClient
        .query("birthday_quotes", where: "id = ?", whereArgs: [id]);

    if (!result.isEmpty) {
      setState(() {
        birthDayQUote = result[0]["quote"];
      });
    } else {
      setState(() {
        birthDayQUote = "No qoute today";
      });
    }
    getUsersDateOfBirth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: mainColor,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/images/logo.png"),

              Text(
                "Self Motivationgs and Quote",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              //   MaterialButton(
              //     child: Text("mmmmm"),
              //     onPressed:(){
              //       print(Time(14,12).toString());
              //        _repeatNotification();
              //       final now = DateTime.now();
              // final tt = DateTime(2020,10,05);
              //  if(tt.day.toString() == now.day.toString()){
              //    print("ppp");
              //  }

              //     }
              //   )
            ],
          ),
        ),
      ),
    );
  }

  Future onSelected(String payLoad) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext) => SingleBirthdayQuote(
              birthdayQuote: birthDayQUote,
            )));
  }
}
