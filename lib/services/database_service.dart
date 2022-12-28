import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bonvoyage/models/ferry_ticket.dart';
import 'package:bonvoyage/models/users.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseServices
 {
  static final DatabaseServices _databaseService = DatabaseServices._internal();
  factory DatabaseServices() => _databaseService;
  DatabaseServices._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'ferryticketapp.db');
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE user(user_id INT PRIMARY KEY AUTOINCREMENT,f_name TEXT,l_name TEXT,username TEXT,password TEXT,mobilehp TEXT',
    );
    await db.execute('CREATE TABLE ferryticket(book_id INT PRIMARY KEY AUTOINCREMENT,depart_date TEXT,journey TEXT,depart_route TEXT,dest_route TEXT,FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE SET NULL)',
    );
  }
/////////////////////////////////tukar nama variable//////////////////////////////



Future<FerryTicket> ferryTicket(int id) async {
  final db = await _databaseService.database;
  final List<Map<String, dynamic>> maps =
    await db.query('ferryticket', where: 'if = ?', whereArgs: [id]);
  return FerryTicket.fromMap(maps[0]);
}


  Future<void> insertFerryTicket(FerryTicket ferryTicket) async {
    final db = await _databaseService.database;
    await db.insert(
      'ferryticket',
      ferryTicket.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> editFerryTicket(FerryTicket ferryTicket) async {
    final db = await _databaseService.database;
    await db.update(
      'ferryticket',
      ferryTicket.toMap(),
      where: 'id = ?',
      whereArgs: [ferryTicket.book_id],
    );
  }
  
  Future<void> deleteFerryTicket(FerryTicket ferryTicket) async {
    final db = await _databaseService.database;
    await db.delete(
      'ferryticket',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> registerUser(User user) async {
    final db = await _databaseService.database;
    await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> userLogin(String username, String password) async {
    final db = await _databaseService.database;
    var res = await db.rawQuery(
      "SELECT * FROM user WHERE username = '$username' and password = '$password'");
    if (res.isNotEmpty) {
      return User.fromMap(res.first);
    } else{
      return null;
    }
  }
 }