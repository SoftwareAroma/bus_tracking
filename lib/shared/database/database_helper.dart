import 'package:bus_tracking/index.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  /// create an instance member for the class [DatabaseHelper]
  static final DatabaseHelper instance = DatabaseHelper._init();

  /// [Database] instance
  static Database? _database;

  /// initialize [DatabaseHelper]
  DatabaseHelper._init();

  /// get the [Database] from file
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(ProjectVariables.databasePath);
    return _database!;
  }

  /// initialize the Local [Database]
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  /// create [UserModel], [DriverModel], [BusModel] table in the database
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT,
        lastName TEXT,
        password TEXT,
        otherName TEXT,
        email TEXT,
        avatar TEXT,
        phone TEXT,
        department TEXT,
        faculty TEXT,
        college TEXT,
        level TEXT,
        events TEXT,
        programme TEXT,
        referenceNumber TEXT,
        updatedAt TEXT,
        deletedAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE drivers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        imageUrl TEXT,
        rating REAL,
        bus TEXT,
        updatedAt TEXT,
        deletedAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE buses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        imageUrl TEXT,
        price TEXT,
        rating TEXT,
        duration TEXT,
        source TEXT,
        destinations TEXT,
        departureTime TEXT,
        arrivalTime TEXT,
        busType TEXT,
        createdAt TEXT,
        updatedAt TEXT,
        deletedAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        time TEXT
      )
    ''');
  }
}
