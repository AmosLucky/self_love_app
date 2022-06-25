import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:main_tessy_app/constants.dart';
import 'package:main_tessy_app/database/database_helper.dart';


class SingleQuote extends StatefulWidget {
  int index;
  SingleQuote({this.index});

  @override
  _SingleQuoteState createState() => _SingleQuoteState();
}

class _SingleQuoteState extends State<SingleQuote> {
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    databaseHelper = DatabaseHelper();
    getAllQuotes();
    // TODO: implement initState
    super.initState();
  }

  getAllQuotes() async {
    var dbClient = await databaseHelper.database;
    var result = await dbClient.query("all_quotes", orderBy: "id desc");
    return result;
  }

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
                child: FutureBuilder(
                  future: getAllQuotes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                        child: Center(
                          child: Text("An Error Occoured"),
                        ),
                      );
                    } else if (snapshot.data == null || snapshot.data == "[]") {
                      return Container(
                        child: Center(
                          child: Text("No Quote"),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return DisplaySingleQuote(
                          list: snapshot.data, index: widget.index);
                    } else {
                      return Container(
                        child: Center(
                          child: Text("An Error Occoured .."),
                        ),
                      );
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}

class DisplaySingleQuote extends StatefulWidget {
  List list;
  int index;
  DisplaySingleQuote({this.list, this.index});

  @override
  _DisplaySingleQuoteState createState() => _DisplaySingleQuoteState();
}

class _DisplaySingleQuoteState extends State<DisplaySingleQuote> {
  var msg = "";
  var isShown = false;
  void cancelLoading() {
    if (isShown) {
      Timer(Duration(seconds: 2), () {
        setState(() {
          isShown = false;
        });
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
  int randomNumber;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width / 4.6),
      //  height: MediaQuery.of(context).size.height,

      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, i) {
          return Column(
            children: <Widget>[
              Container(
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
                  widget.list[widget.index]['quote'],
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 15),
                ),
              ), //),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      shape: StadiumBorder(),
                      color: mainColor,
                      textColor: Colors.white,
                      child: Text("<< Previous"),
                      onPressed: () {
                        if (widget.index >= 1) {
                          generateRand();
                          setState(() {
                            widget.index--;
                          });
                        } else {
                          setState(() {
                            isShown = true;
                            cancelLoading();
                          });
                          //widget.index ++;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                  Expanded(
                    child: MaterialButton(
                      shape: StadiumBorder(),
                      color: mainColor,
                      textColor: Colors.white,
                      onPressed: () {
                        if (widget.index < widget.list.length - (1)) {
                          generateRand();
                          setState(() {
                            widget.index++;
                          });
                        } else {
                          setState(() {
                            isShown = true;
                            cancelLoading();
                          });
                          //widget.index ++;
                        }
                      },
                      child: Text("Next >>"),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
              ),
              isShown ? Text("End of Quote") : Text("")
            ],
          );
        },
      ),
    );
  }
}
