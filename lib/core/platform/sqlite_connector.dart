import 'package:sqflite/sqflite.dart';

abstract class SqliteConnector{
  Future<Database> getDatabaseInstance();
}