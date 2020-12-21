import 'package:sqflite/sqflite.dart';
import 'package:women_safety_app/services/contacts.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String contactTable = 'contact_table';
  String colId = 'id';
  String colContactName = 'name';
  String colContactNumber = 'number';

  //named constructor
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    //factory keyword allows the constructor to return some value
    if (_databaseHelper == null) {
      //create an instance of _DatabaseHelper iff there is no instance created before
      _databaseHelper = DatabaseHelper._createInstance();
      //because of that null check this line above runs once only
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    String directoryPath = await getDatabasesPath();
    String dbLocation = directoryPath + 'contact.db';

    var contactDatabase = await openDatabase(dbLocation, version: 1, onCreate: _createDb);
    return contactDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $contactTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colContactName TEXT, $colContactNumber TEXT)');
  }

  // Fetch Operation: get contact object from db
  Future<List<Map<String, dynamic>>> getContactMapList() async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.rawQuery('SELECT * FROM $contactTable order by $colId ASC');

    // or
    // var result = await db.query(contactTable, orderBy: '$colId ASC');
    return result;
  }

  //Insert a contact object
  Future<int> insertContact(Contacts contact) async{
    Database db = await this.database;
    var result = await db.insert(contactTable, contact.toMap());
    return result;
  }

  //update a contact object
  Future<int> updateContact(Contacts contact) async{
    Database db = await this.database;
    var result = await db.update(contactTable, contact.toMap(), where:'$colId = ?',whereArgs: [contact.id]);
    return result;
  }

  //delete a contact object
  Future<int> deleteContact(int id) async{
    Database db = await this.database;
    int result = await db.rawDelete('DELETE FROM $contactTable WHERE $colId = $id');
    return result;
  }

  //get number of contact objects
  Future<int> getCount(int id) async{
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $contactTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
}