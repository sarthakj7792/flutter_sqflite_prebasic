// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'dart:async';

import '../models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static late Database _db;

  Future<Database> get db async {
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(id Integer primary key,username text,password text)");
    log('Table is created');
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert('User', user.toMap());
    return res;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete('User');
    return res;
  }
}
