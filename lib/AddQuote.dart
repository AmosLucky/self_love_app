import 'package:flutter/material.dart';
import 'package:main_tessy_app/LoveQuotes.dart';
import 'package:main_tessy_app/constants.dart';
import 'package:main_tessy_app/database/database_helper.dart';

class AddQuote extends StatefulWidget {
  @override
  _AddQuoteState createState() => _AddQuoteState();
}

class _AddQuoteState extends State<AddQuote> {
  DatabaseHelper databaseHelper;
  String newQuote;
      GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    databaseHelper = new DatabaseHelper();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var hieght = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
       onWillPop: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext)=>LoveQuotePage()));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add QUote"),
          centerTitle: true,
          backgroundColor: mainColor,
          elevation: 0.0,
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: hieght / 7.5,
              color: mainColor,
            ),
            Container(
          
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
              
              margin: EdgeInsets.only(top: hieght / 9, right: 20, left: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      
                      decoration: InputDecoration(
                       
                        hintText: "Write a quote....",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                        ),

                      maxLines: 5,
                      validator: (value) {
                        if (value.trim().length < 5) {
                          return "please write a valid quote";
                        }
                      },
                      onSaved: (value) {
                        newQuote = value;
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top:20),),
                    Row(children: <Widget>[
                      Expanded(child: MaterialButton(
                        shape: StadiumBorder(),
                        onPressed: () async {
                          if(_formKey.currentState.validate()){
                            _formKey.currentState.save();

                            var dbClient =  databaseHelper;
                            //print(newQuote);
                            
                     int row = await   dbClient.addQuote({"quote": newQuote});
                     if(row > 0){
                       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext)=>LoveQuotePage()));
                    
                     }
                          }

                        },
                        textColor: Colors.white,
                        color: mainColor,
                        child: Text("Add Quote"),),)
                    ],)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
