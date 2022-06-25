import 'package:flutter/material.dart';
import 'package:main_tessy_app/AddQuote.dart';
import 'package:main_tessy_app/SingleQuote.dart';
import 'package:main_tessy_app/UserDashbord.dart';
import 'package:main_tessy_app/constants.dart';
import 'package:main_tessy_app/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class LoveQuotePage extends StatefulWidget {
  @override
  _LoveQuotePageState createState() => _LoveQuotePageState();
}

class _LoveQuotePageState extends State<LoveQuotePage> {
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
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext) => UserDashboard()));
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: mainColor,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext) => AddQuote()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("All Self Love Quotes"),
          centerTitle: true,
          backgroundColor: mainColor,
          elevation: 0.0,
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
                  padding: EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 0.0),
                  child: FutureBuilder(
                    future: getAllQuotes(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          child: Center(
                            child: Text("An Error Occoured"),
                          ),
                        );
                      } else if (snapshot.data == null ||
                          snapshot.data == "[]") {
                        return Container(
                          child: Center(
                            child: Text("Loading Quote ..."),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        return ListOfQuotes(
                          list: snapshot.data,
                          databaseHelper: databaseHelper,
                        );
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
      ),
    );
  }
}

class ListOfQuotes extends StatefulWidget {
  List list;
  DatabaseHelper databaseHelper;

  ListOfQuotes({this.list, this.databaseHelper});
  @override
  _ListOfQuotesState createState() => _ListOfQuotesState();
}

class _ListOfQuotesState extends State<ListOfQuotes> {
  // List list1 = widget.list;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width / 20),
      //  height: MediaQuery.of(context).size.height,

      child: ListView.builder(
        itemCount: widget.list == null ? 0 : widget.list.length,
        itemBuilder: (context, index) {
          return Card(
              child: Container(
            height: MediaQuery.of(context).size.height / 11,
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext) => SingleQuote(
                          index: index,
                        )));
              },
              leading: Icon(
                Icons.favorite,
                color: Colors.redAccent,
              ),
              title: widget.list[index]['quote'].toString().length > 40
                  ? Text(
                      widget.list[index]['quote'].toString().substring(0, 30) +
                          "...")
                  : Text(widget.list[index]['quote'] + "..."),
              trailing: InkWell(
                child: Icon(
                  Icons.delete,
                  size: 20,
                ),
                onTap: () {
                  showAlertDialog(
                      context,
                      "Delete",
                      "You are about to delete this quote?",
                      widget.list[index]['id']);
                },
              ),
            ),
          ));
        },
      ),
    );
  }

  showAlertDialog(BuildContext context, String title, String message, int id) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget deleteBtn = FlatButton(
      child: Text("Ok"),
      onPressed: () {
        widget.databaseHelper.delete(id);
        Navigator.pop(context);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext) => LoveQuotePage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [okButton, deleteBtn],
    );

    // show the dialog
    showDialog(
      // barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
