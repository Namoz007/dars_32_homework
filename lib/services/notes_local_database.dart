
import 'package:sqflite/sqflite.dart';
import 'package:working/controllers/notes_controller.dart';
import 'package:working/models/contact.dart';
import 'package:working/models/notes.dart';

class NotesLocalDatabase {
  NotesLocalDatabase._contactLocalData();

  static final NotesLocalDatabase _localdatabase =
  NotesLocalDatabase._contactLocalData();

  factory NotesLocalDatabase() {
    return _localdatabase;
  }

  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDataBase();
    return _database!;
  }

  Future<Database> _initDataBase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/notes.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute('''
CREATE TABLE notes (
id INTEGER PRIMARY KEY AUTOINCREMENT,
description TEXT NOT NULL,
date String
);
''');
  }

  Future<void> addNote(Note note) async {
    await _database!.insert('notes', {
      "id":note.id,
      "description": note.description,
      "date": note.date.toString(),
    });
  }

  Future<List<Note>> getNotes() async {
    List<Map<String, dynamic>>? rows = await _database?.query('notes');
    List<Note> loadedContacts = [];
    print('Bu sqldagi malumotlar $rows');
    if (rows != null) {
      for (var element in rows) {
        loadedContacts.add(Note.fromJson(element));
      }
    }
    return loadedContacts;
  }


  Future<void> deleteNote(int id) async {
    await _database!.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
