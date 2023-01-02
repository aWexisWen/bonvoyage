import 'dart:io';

import 'package:bonvoyage/pages/view_ticket.dart';
import 'package:flutter/material.dart';
import 'package:bonvoyage/models/ferry_ticket.dart';
import 'package:bonvoyage/models/users.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bonvoyage/pages/ticket_form_page.dart';

class DatabaseServices {
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
    await db.execute(
      'CREATE TABLE user(user_id INTEGER PRIMARY KEY AUTOINCREMENT,f_name TEXT,l_name TEXT,username TEXT,password TEXT,mobilehp TEXT)',
    );
    await db.execute(
      'CREATE TABLE ferryticket(book_id INTEGER PRIMARY KEY AUTOINCREMENT,depart_date TEXT,journey TEXT,depart_route TEXT,dest_route TEXT,user_id INTEGER, FOREIGN KEY (user_id) REFERENCES user(user_id) ON DELETE SET NULL)',
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

  Future<List<FerryTicket>> getFerryTickets() async {
    // Get a reference to the database.
    final db = await _databaseService.database;
    // Query the table for all the Brands.
    final List<Map<String, dynamic>> maps = await db.query('ferryticket');
    // Convert the List<Map<String, dynamic> into a List<Brand>.
    return List.generate(
        maps.length, (index) => FerryTicket.fromMap(maps[index]));
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
      whereArgs: [ferryTicket.book_id],
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

  Future<User?> userLogin(User user, BuildContext context) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'username = ? and password = ?',
      whereArgs: [user.username, user.password],
    );

    if (result.isEmpty) {
      print(user);
      // ignore: use_build_context
      // _synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Wrong password or username. Log in unsuccessful.')),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome, ${user.username}!')),
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ViewTicketPage()),
      );
    }
  }
}
