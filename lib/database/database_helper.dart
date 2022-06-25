import 'dart:io';

import 'package:flutter/material.dart';
import 'package:main_tessy_app/Quotes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  String check;
  DatabaseHelper({this.check});
  static final dbName = "tessy.db";
  static final dbVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initializeDatabase();
      return _database;
    }
  }

  _initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    var db = await openDatabase(path, version: dbVersion, onCreate: _onCreate);
    return db;
  }
  

  Future _onCreate(Database db, int version) {
    //////////////////////////
    saveDay(1);
    final now = DateTime.now();
    var date = now.day.toString() + now.year.toString();
    saveDate(date);
    showBirthDayQuote("false");
    ///////////////////////
    db.execute('''
     CREATE TABLE users( 
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       username TEXT NOT NULL,
       DOB DATETIME NOT NULL,
       email TEXT NOT NULL,
       password TEXT NOT NULL

      )
   ''');
   /////////////////////////////////// create daily quotes db//////////
    db.execute('''
     CREATE TABLE daily_quotes( 
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       quote TEXT NOT NULL
       

      )
   ''');
   
   ///////////////insert into daily quotes table/////////
   for(int i = 0; i < daily_quotes.length; i++){
     db.insert("daily_quotes", {"quote":daily_quotes[i]});
   }
   ///////////////////end///////////////////
   ////////////////////////////////// create daily all_quotes db//////////
   db.execute('''
     CREATE TABLE all_quotes( 
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       quote TEXT NOT NULL
       

      )
   ''');
   ///////////////insert into daily quotes table/////////
   for(int i = 0; i < self_love_quotes.length; i++){
     db.insert("all_quotes", {"quote":self_love_quotes[i]});
   }
   ///////////////////end///////////////////
   ///////////////////////////////////// create daily all_quotes db//////////
   db.execute('''
     CREATE TABLE birthday_quotes( 
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       quote TEXT NOT NULL
       

      )
   ''');
   ///////////////insert into daily quotes table/////////
   for(int i = 0; i < birthday_quotes.length; i++){
     db.insert("birthday_quotes", {"quote":birthday_quotes[i]});
   }
   ///////////////////end///////////////////
  
     

  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert("users", row);
  }

  Future<List<Map<String, dynamic>>> selectUser(
      String username, String password) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "SELECT * FROM users WHERE username = '$username' && password = '$password' ");
    if (res.length > 0) {
      return res;
    } else {
      return null;
    }
  }

 

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    String username = row["username"];
    return await db.update("users", row, where: 'username = ?', whereArgs: [username]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;

    return await db.delete("all_quotes", where: 'id = ?', whereArgs: [id]);
  }

   Future<int> addDailyQuote(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert("daily_quotes", row);
  }
  Future<int> addQuote(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert("all_quotes", row);
  }
  Future <bool> saveDay(int day)async{
   
    SharedPreferences preference = await SharedPreferences.getInstance();
    // print(oka);
    
   
   return await preference.setInt("day",day);
   

  }
  
  Future <bool> saveDate(String date)async{
    

   
    SharedPreferences preference = await SharedPreferences.getInstance();
    // print(oka);
    
   
   return await preference.setString("date",date);
   

  }
   Future <bool> showBirthDayQuote(String txt)async{
    

   
    SharedPreferences preference = await SharedPreferences.getInstance();
    // print(oka);
    
   
   return await preference.setString("shown",txt);
   

  }
  Future getTodatQuote(String id) async {
    Database db = await instance.database;
    return db.query("daily_quotes", where: "id = ?", whereArgs: [id]);
  }
  
  
}
