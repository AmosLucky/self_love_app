// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:tessy_app/LoginPage.dart';
// import 'package:tessy_app/constants.dart';
// import 'package:tessy_app/database/database_helper.dart';
// class UserDashboard extends StatefulWidget {
//   List<String> userDetailsList;
//   UserDashboard({this.userDetailsList});
//   @override
//   _UserDashboardState createState() => _UserDashboardState();
// }

// class _UserDashboardState extends State<UserDashboard> {
//     DatabaseHelper databaseHelper;
//     String quoteOfTheDay = "";



//   logout() async {
//     //String value = _controller.text;
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     // print(oka);
//     String userDetails = "userDetails";

//     await preference.remove(userDetails);
//     setState(() {
//       //isReg = false;
//     });

//     Navigator.push(
//         context, MaterialPageRoute(builder: (BuildContext) => LoginPage()));
//   }

//   @override
//   Future initState()  {
//     databaseHelper = DatabaseHelper();  
//     getDailyQoutes();
         
//     print(widget.userDetailsList);
//     // TODO: implement initState
//     super.initState();
//   }

//   getDailyQoutes() async {
//       Database dbClient = await databaseHelper.database;
//      var result = await dbClient.query("daily_quotes", columns: ['quote'], where: "id = ?", whereArgs: [1]);

//       if(!result.isEmpty){
        

//         setState(() {
//           quoteOfTheDay = result[0]["quote"];
//         });
//       }else{
//          setState(() {
//           quoteOfTheDay = "No qoute today";
//         });

//       }
      

//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         drawer: Drawer(),
//           appBar: AppBar(
            
//             backgroundColor: mainColor,
//             elevation: 0.0,
//             title: Text(
//               "Tessy Love",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: MediaQuery.of(context).size.width /15
//               ),
//             ),
//             centerTitle: true,
//           ),

//           //backgroundColor: mainColor,
//           body: Column(
//             children: <Widget>[
              
//                 Container(
//                    width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height * 0.3,
//                   decoration: BoxDecoration(
//                     color: mainColor,
                    
//                   ),
//                   child: Container(
//                     margin: EdgeInsets.only(left:20, right: 20,top: 5),
//                     child: Column(
//                      // mainAxisAlignment: MainAxisAlignment.center,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Container(
//                           padding: EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                              color: Colors.pinkAccent,
//                              borderRadius: BorderRadius.all(const Radius.circular(10))),
//                           height: MediaQuery.of(context).size.width/2.5,
                         
//                           width: MediaQuery.of(context).size.width,
//                           child: Center(child: Text(quoteOfTheDay,style: TextStyle( color: Colors.white,fontSize: 18))),
//                           ),
//                         Container(
                         
//                           margin: EdgeInsets.only(top:5),
//                           child: Text("Quote for the day",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),)
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
              

//               ///////////////////////////////////////////////////////////////

             
//                 // padding: EdgeInsets.symmetric(horizontal:20),

              
              
//             ],
//           )),
//     );
//   }
// }




///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:tessy_app/LoginPage.dart';
// import 'package:tessy_app/constants.dart';
// import 'package:tessy_app/database/database_helper.dart';
// class UserDashboard extends StatefulWidget {
//   List<String> userDetailsList;
//   UserDashboard({this.userDetailsList});
//   @override
//   _UserDashboardState createState() => _UserDashboardState();
// }

// class _UserDashboardState extends State<UserDashboard> {
//     DatabaseHelper databaseHelper;
//     String quoteOfTheDay = "";



//   logout() async {
//     //String value = _controller.text;
//     SharedPreferences preference = await SharedPreferences.getInstance();
//     // print(oka);
//     String userDetails = "userDetails";

//     await preference.remove(userDetails);
//     setState(() {
//       //isReg = false;
//     });

//     Navigator.push(
//         context, MaterialPageRoute(builder: (BuildContext) => LoginPage()));
//   }

//   @override
//   Future initState()  {
//     databaseHelper = DatabaseHelper();  
//     getDailyQoutes();
         
//     print(widget.userDetailsList);
//     // TODO: implement initState
//     super.initState();
//   }

//   getDailyQoutes() async {
//       Database dbClient = await databaseHelper.database;
//      var result = await dbClient.query("daily_quotes", where: "id = ?", whereArgs: [1]);

//       if(!result.isEmpty){
        

//         setState(() {
//           quoteOfTheDay = result[0]["quote"];
//         });
//       }else{
//          setState(() {
//           quoteOfTheDay = "No qoute today";
//         });

//       }
      

//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         drawer: Drawer(),
//           appBar: AppBar(
            
//             backgroundColor: mainColor,
//             elevation: 0.0,
//             title: Text(
//               "Tessy Love",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: MediaQuery.of(context).size.width /15
//               ),
//             ),
//             centerTitle: true,
//           ),

//           //backgroundColor: mainColor,
//           body: Stack(
//             children: <Widget>[
//               Container(
//                 alignment: Alignment.center,
//                 height: MediaQuery.of(context).size.height * 0.5,
//                 width: MediaQuery.of(context).size.width,
//                 child: Container(
//                    width: MediaQuery.of(context).size.width,
//                     height: MediaQuery.of(context).size.height * 0.5,
//                   decoration: BoxDecoration(
//                     color: mainColor,
                    
//                   ),
//                   child: Container(
//                     margin: EdgeInsets.only(left:20, right: 20,top: 5),
//                     child: Column(
//                      // mainAxisAlignment: MainAxisAlignment.center,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//                         Container(
//                           padding: EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                              color: Colors.pinkAccent,
//                              borderRadius: BorderRadius.all(const Radius.circular(10))),
//                           height: MediaQuery.of(context).size.width/2.1,
                         
//                           width: MediaQuery.of(context).size.width,
//                           child: Center(child: Text(quoteOfTheDay,style: TextStyle( color: Colors.white,fontSize: 18))),),
//                         Container(
//                           margin: EdgeInsets.only(top:10),
//                           child: Text("Quote for the day",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.white),)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),

//               ///////////////////////////////////////////////////////////////

//               Container(
//                 margin: EdgeInsets.only(top: 250),

//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 // padding: EdgeInsets.symmetric(horizontal:20),
//                 child: GridView.count(
//                   crossAxisCount: 2,
//                   children: <Widget>[
//                     ///////////////////////////////// one row ///////////////////////
//                     /////////////////////Right //////////////////

//                     Container(
//                       //padding: EdgeInsets.only(left: 10),
//                       height: MediaQuery.of(context).size.height,
//                       margin: EdgeInsets.only(right: 5, left: 10),
//                       child: Material(
//                         elevation: 5.0,
//                         borderRadius: BorderRadius.all(
//                           const Radius.circular(10),
//                         ),
//                         child: MaterialButton(
//                           splashColor: mainColor,
//                           onPressed: () {},
//                           child: Center(
//                               child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Container(
//                                   padding: EdgeInsets.all(15),
//                                   decoration: BoxDecoration(
//                                     color: mainColor,
//                                     borderRadius: BorderRadius.all(
//                                       const Radius.circular(50),
//                                     ),
//                                   ),
//                                   child: Icon(
//                                     Icons.chevron_right,
//                                     color: Colors.white,
//                                   )),
//                               Container(
//                                   margin: EdgeInsets.only(top: 5),
//                                   child: Text(
//                                     "Daily Quotes",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: 'Indies'),
//                                   )),
//                             ],
//                           )),
//                         ),
//                       ),
//                     ),

//                     //////////////////////////////// left//////////////////

//                     Container(
//                       margin: EdgeInsets.only(left: 5, right: 10),
//                       child: Material(
//                         elevation: 5.0,
//                         borderRadius: BorderRadius.all(
//                           const Radius.circular(10),
//                         ),
//                         child: MaterialButton(
//                           splashColor: mainColor,
//                           onPressed: () {},
//                           child: Center(
//                               child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Container(
//                                   padding: EdgeInsets.all(15),
//                                   decoration: BoxDecoration(
//                                     color: mainColor,
//                                     borderRadius: BorderRadius.all(
//                                       const Radius.circular(50),
//                                     ),
//                                   ),
//                                   child: Icon(
//                                     Icons.chevron_right,
//                                     color: Colors.white,
//                                   )),
//                               Container(
//                                   margin: EdgeInsets.only(top: 5),
//                                   child: Text(
//                                     "Daily Quotes",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: 'Indies'),
//                                   )),
//                             ],
//                           )),
//                         ),
//                       ),
//                     ),
//                     ///////////////////////////////////////////// one row////////////////////////////////
//                     ///

//                     ///////////////////////////////// one row ///////////////////////
//                     /////////////////////Right //////////////////

//                     Container(
//                       margin: EdgeInsets.only(right: 5, top: 10, left: 10),
//                       child: Material(
//                         elevation: 5.0,
//                         borderRadius: BorderRadius.all(
//                           const Radius.circular(10),
//                         ),
//                         child: MaterialButton(
//                           splashColor: mainColor,
//                           onPressed: () {},
//                           child: Center(
//                               child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Container(
//                                   padding: EdgeInsets.all(15),
//                                   decoration: BoxDecoration(
//                                     color: mainColor,
//                                     borderRadius: BorderRadius.all(
//                                       const Radius.circular(50),
//                                     ),
//                                   ),
//                                   child: Icon(
//                                     Icons.chevron_right,
//                                     color: Colors.white,
//                                   )),
//                               Container(
//                                   margin: EdgeInsets.only(top: 5),
//                                   child: Text(
//                                     "Daily Quotes",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: 'Indies'),
//                                   )),
//                             ],
//                           )),
//                         ),
//                       ),
//                     ),

//                     //////////////////////////////// left//////////////////

//                     Container(
//                       margin: EdgeInsets.only(left: 5, top: 10, right: 10),
//                       child: Material(
//                         elevation: 5.0,
//                         borderRadius: BorderRadius.all(
//                           const Radius.circular(10),
//                         ),
//                         child: MaterialButton(
//                           splashColor: mainColor,
//                           onPressed: () {},
//                           child: Center(
//                               child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Container(
//                                   padding: EdgeInsets.all(15),
//                                   decoration: BoxDecoration(
//                                     color: mainColor,
//                                     borderRadius: BorderRadius.all(
//                                       const Radius.circular(50),
//                                     ),
//                                   ),
//                                   child: Icon(
//                                     Icons.chevron_right,
//                                     color: Colors.white,
//                                   )),
//                               Container(
//                                   margin: EdgeInsets.only(top: 5),
//                                   child: Text(
//                                     "Daily Quotes",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: 'Indies'),
//                                   )),
//                             ],
//                           )),
//                         ),
//                       ),
//                     ),
//                     ///////////////////////////////////////////// one row////////////////////////////////
//                   ],
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }
