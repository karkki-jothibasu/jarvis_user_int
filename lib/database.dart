import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:typed_data';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initializeDatabase();

    return _database!;
  }

  static Future<Database> initializeDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'jarvis.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
  CREATE TABLE chats(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    title TEXT,
    question TEXT, 
    answer TEXT
  )
''');
      },
    );
  }

  static Future<int> insertchats(
      {required String title,
      required String question,
      required String answer}) async {
    final Database db = await database;

    final Map<String, dynamic> chat = <String, dynamic>{
      'title': title,
      'question': question,
      'answer': answer
    };

    return await db.insert('chats', chat);
  }

  static Future<int> deletechat(int id) async {
    final Database db = await database;

    return await db.delete('chats', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getchats() async {
    final Database db = await database;

    return db.query('chats', orderBy: 'title ASC');
  }
}
