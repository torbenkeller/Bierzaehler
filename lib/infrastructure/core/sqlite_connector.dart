import 'package:bierzaehler/infrastructure/core/i_sqlite_connector.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

@LazySingleton(as: ISqliteConnector)
class SqliteConnectorImpl implements ISqliteConnector {
  Database _database;

  @override
  Future<Database> getDatabaseInstance() async {
    if (_database != null) return _database;
    final String databasesPath = await databaseFactory.getDatabasesPath();
    _database = await databaseFactory.openDatabase(databasesPath + 'Bierzaehler.db',
        options: OpenDatabaseOptions(
            version: 1,
            onCreate: (Database db, int version) async {
              await db.execute('CREATE TABLE "Category" ('
                  '"catID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'
                  '"name"	TEXT NOT NULL UNIQUE'
                  ')');
              await db.execute('CREATE TABLE "Drink" ('
                  '"driID"	INTEGER PRIMARY KEY AUTOINCREMENT,'
                  '"bevID"	INTEGER NOT NULL,'
                  '"size"	REAL NOT NULL CHECK("Size" > 0),'
                  'FOREIGN KEY("BevID") REFERENCES "Beverage"("BevID") on delete cascade'
                  ')');
              await db.execute('CREATE TABLE "Price" ('
                  '"priID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'
                  '"driID"	INTEGER NOT NULL,'
                  '"price"	REAL NOT NULL CHECK("Price">=0),'
                  'FOREIGN KEY("DriID") REFERENCES "Drink"("DriID") on delete cascade'
                  ')');
              await db.execute('CREATE TABLE "List" ('
                  '"lisID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'
                  '"ended"	UNSIGNED INTEGER(1) NOT NULL DEFAULT 0,'
                  '"date"	TEXT NOT NULL'
                  ')');
              await db.execute(' CREATE TABLE "Beverage" ('
                  '"bevID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'
                  '"catID"	INTEGER NOT NULL,'
                  '"name"	TEXT NOT NULL UNIQUE,'
                  '"color"	UNSIGNED INTEGER(32) NOT NULL DEFAULT 4286259106,'
                  '"alcohol"	REAL NOT NULL DEFAULT 0.0 CHECK("Alcohol">=0.0 and Alcohol<=1.0),'
                  'FOREIGN KEY("CatID") REFERENCES "Category"("CatID") on delete cascade'
                  ')');
              await db.execute('CREATE TABLE "ListItem" ('
                  '"lisID"	INTEGER NOT NULL,'
                  '"useID"	INTEGER NOT NULL,'
                  'PRIMARY KEY("LisID","UseID"),'
                  'FOREIGN KEY("UseID") REFERENCES "Use"("UseID") on delete cascade,'
                  'FOREIGN KEY("LisID") REFERENCES "List"("LisID") on delete cascade'
                  ')');
              await db.execute('CREATE TABLE "Use" ('
                  '"useID"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,'
                  '"priID"	INTEGER NOT NULL,'
                  '"date"	TEXT NOT NULL,'
                  'FOREIGN KEY("PriID") REFERENCES "Price"("PriID") on delete cascade'
                  ')');
            }));
    return _database;
  }
}
