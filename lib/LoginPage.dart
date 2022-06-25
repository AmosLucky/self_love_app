import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_tessy_app/Registration.dart';
import 'package:main_tessy_app/UserDashbord.dart';
import 'package:main_tessy_app/database/database_helper.dart';
import 'package:sqflite/sqlite_api.dart';

import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  DatabaseHelper databaseHelper;
  
  String username;
  String password;
  List<String> userDetailsList;
  String userDetails = "userDetails";
   check()async{
    loadData().then((val){
      if(val == null){
        print("Not Registered");
      }else{
        setState(() {
          userDetailsList = val;
        });

                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext)=>UserDashboard( userDetailsList: userDetailsList,)));

      }

    });

  }
  @override
  void initState() {
    databaseHelper = DatabaseHelper();

    /////////////////
    const MethodChannel('plugins.flutter.io/shared_preferences')
    .setMethodCallHandler(
      (MethodCall methodCall)async{

        if(methodCall.method == "getAll"){
          return {"flutter." + "pppp" : "NO RECORD"};


        }
        return null;
      }
    );

    ///////////////////////////////////////// check if user exists/////////////////////
     //check();
    
    // TODO: implement initState
    super.initState();
  }

  //////////////////load data from sharepreference
  Future <List> loadData() async{
    SharedPreferences preference = await SharedPreferences.getInstance();
   return  preference.getStringList(userDetails);
    
  }

  /////////////////////save record in sharedPreference
  Future <bool> savaData({String username, String password,String dob,String email,String i})async{
   
    SharedPreferences preference = await SharedPreferences.getInstance();
    // print(oka);
    
   
   return await preference. setStringList(userDetails, [username,password,dob,email]);
   

  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

   bool isLoading = false;
   String message = "";
  void cancelLoading(){
    if(isLoading){
      Timer(Duration(seconds: 2),(){

        setState(() {
          isLoading =false;
        });
      });
    }
  }
  
var _scaffoldKey = GlobalKey<ScaffoldState>();
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
                    _buildContainer(),
                    _buildSigningButton(),
                   
                  ],
                )
              ],
            ),
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
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: BoxDecoration(color: Colors.white),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 30,
                        fontWeight: FontWeight.bold,
                        //color: Colors.white
                      ),
                    ),
                    _buildEmail(),
                    _buildPassword(),
                    _buildForgetPasswordButton(),
                    _buildLoginButton(),
                     isLoading? Text("Loading..."): Text(""),
                    Padding(padding: EdgeInsets.only(top:5),),
                    Text(message),
                     Padding(padding: EdgeInsets.only(top:5),),
                    _buildRow(),
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
        onChanged: (value) {
          username = value;
        },
        onSaved: (value) {
          username = value;
        },
        validator: (value) {
          if (value.length < 2) {
            return "Username is too short";
          }
        },
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person,
              color: mainColor,
            ),
            labelText: "Username"),
      ),
    );
  }

  _buildPassword() => Padding(
        padding: EdgeInsets.all(8),
        child: TextFormField(
          obscureText: true,
          onChanged: (value) => password = value,
          onSaved: (value) {
            password = value;
          },
          validator: (value) {
            if (value.length < 5) {
              return "Password is to short";
            }
          },
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: mainColor,
              ),
              labelText: "Password"),
        ),
      );

  _buildForgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text("Forget Password"),
        ),
      ],
    );
  }

  _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * MediaQuery.of(context).size.height / 20,
          width: 5 * MediaQuery.of(context).size.width / 10,
          margin: EdgeInsets.only(bottom: 20),
          child: RaisedButton(
            color: mainColor,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Text(
              "Login",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height / 40,
                  letterSpacing: 1.5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
             if(_formKey.currentState.validate()){
               _formKey.currentState.save();
                 setState(() {
                  message ="";
                  isLoading = true;
                });
                 cancelLoading();
              Database dbClient = await databaseHelper.database;

              var result = await dbClient.query("users",
                  columns: ['username','password','email','DOB','id'],
                  where: "username = ? AND password = ?",
                  whereArgs: [username,password]);
                   if(!result.isEmpty){
                     print("gooo");
                    var username = result[0]['username'];
                   var  password = result[0]['password'];
                   var  dob = result[0]['dob'];
                   var email = result[0]['email'];
                   var id = result[0]['id'];
                   /// print("details  :"+ dob);
                     

                    bool isSaved = await savaData(username: username,password: password,dob: dob,email: email,i:id.toString());
                    if(isSaved){

                      /////// to dashboard ////
                      check();
                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext)=>UserDashboard()));

                    


                    }else{
                      print("NOT SAVED");
                    }
                    //  setState(() {
                    //    message = "Valid Usename";
                    //  });
               //      final now = DateTime.now();
            // final tt = DateTime(2020,09,14);
            //  var parsedDate = DateTime.parse(result[0]['DOB']);
            //  print(parsedDate);
            //  print(tt);
            //   if(tt.month == parsedDate.month){
            //     print("ppp");
            //   }
                 
               }else{
                 setState(() {
                   message = "invalid username or password";
                 });

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
                  MaterialPageRoute(builder: (BuildContext) => Registration()));
            },
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Dont have an account?",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: MediaQuery.of(context).size.height / 40,
                        color: Colors.black)),
                TextSpan(
                    text: "  Sign Up",
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
