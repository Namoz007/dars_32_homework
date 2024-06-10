
import 'package:sqflite/sqflite.dart';
import 'package:working/models/contact.dart';

class ContactsLocalDatabase {
  ContactsLocalDatabase._contactLocalData();

  static final ContactsLocalDatabase _localdatabase =
  ContactsLocalDatabase._contactLocalData();

  factory ContactsLocalDatabase() {
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
    final path = '$databasePath/contacts.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute('''
CREATE TABLE contact (
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT NOT NULL,
phone TEXT NOT NULL,
image TEXT
);
''');
  }

  Future<void> addContact(Contact contact) async {
    await _database!.insert('contact', {
      "id" : contact.id,
      "name": contact.name,
      "phone": contact.number,
      "image": contact.imgUrl,
    });
  }

  Future<List<Contact>> getContacts() async {
    List<Map<String, dynamic>>? rows = await _database?.query('contact');
    List<Contact> loadedContacts = [];
    print('Bu sqldagi malumotlar $rows');
    if (rows != null) {
      for (var element in rows) {
        loadedContacts.add(Contact.fromJson(element));
      }
    }
    return loadedContacts;
  }


  Future<void> deleteContact(int id) async {
    await _database!.delete(
      'contact',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
