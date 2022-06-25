import 'package:flutter/material.dart';
import 'package:main_tessy_app/constants.dart';
class GetHelp extends StatefulWidget {
  @override
  _GetHelpState createState() => _GetHelpState();
}

class _GetHelpState extends State<GetHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0.0,
          title: Text(
            "Get Help",
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
                 padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height / 11,
            child: Text('''
                    Help center

If you have any questions, suggestions or
 issues concerning the app, contact us via

Email: theselfloveapp@gmail.com
            ''',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
          
          )
          )
                 
          ),
            ],
          ),
        ),
    );
  }
}