import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:main_tessy_app/constants.dart';
import 'package:main_tessy_app/database/database_helper.dart';


class SingleBirthdayQuote extends StatefulWidget {
  String birthdayQuote;
  SingleBirthdayQuote({this.birthdayQuote});

  @override
  _SingleBirthdayQuote createState() => _SingleBirthdayQuote();
}

class _SingleBirthdayQuote extends State<SingleBirthdayQuote> {
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    generateRand();
   
    // TODO: implement initState
    super.initState();
  }

   generateRand() {
    Random random = new Random();
    var rand = random.nextInt(10);
    setState(() {
      randomNumber = rand;
    });
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
  int randomNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Self Love "),
        centerTitle: true,
        backgroundColor: mainColor,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              color: mainColor,
              height: 60,
            ),
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 0.0),
                child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/" + images[randomNumber] + ".jpg"),
                    fit: BoxFit.cover,
                  ),

                  ///color: Colors.pinkAccent,
                ),
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height / 2,
                padding: EdgeInsets.all(10.0),
                child: Text(
                  widget.birthdayQuote,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 15),
                ),
              ),),
          ],
        ),
      ),
    );
  }
}
