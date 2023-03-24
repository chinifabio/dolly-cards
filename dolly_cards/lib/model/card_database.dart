import 'package:dolly_cards/model/card_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CardDatabase {
  static final CardDatabase instance = CardDatabase._init();
  static const String schema = 'cards3.db';
  static Database? _database;

  CardDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(schema);
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    print(path);
    return await openDatabase(path, version: 1, onCreate: _createDB, );
  }

  // executed only when the file do not exists
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const stringType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableCards (
      ${CardFields.id} $idType,
      ${CardFields.name} $stringType,
      ${CardFields.data} $stringType,
      ${CardFields.timestamp} $stringType
    )
    ''');
  }

  Future<CardData> createCardData(CardData cardData) async {
    final db = await instance.database;

    final id = await db.insert(tableCards, cardData.toJson());
    return cardData.copy(id: id);
  }

  Future<CardData> readCardData(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCards,
      columns:
      CardFields.values, where: '${CardFields.id} = ?',
      whereArgs: [id]
    );

    if (maps.isNotEmpty) {
      return CardData.fromJson(maps.first);
    } else {
      throw Exception('card not found');
    }
  }

  Future<List<CardData>> readAll() async {
    final db = await instance.database;

    const orderBy = '${CardFields.timestamp} ASC';
    final result = await db.query(tableCards, orderBy: orderBy);
    return result.map((e) => CardData.fromJson(e)).toList();
  }

  Future<int> update(CardData cardData) async {
    final db = await instance.database;

    return db.update(
      tableCards,
      cardData.toJson(),
      where: '${CardFields.id} = ?',
      whereArgs: [cardData.id]
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableCards,
      where: '${CardFields.id} = ?',
      whereArgs: [id]
    );
  }

  Future close() async {
    final db = await instance.database;
    _database = null;
    return db.close();
  }
}