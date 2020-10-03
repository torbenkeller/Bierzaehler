import 'package:sqflite/sqflite.dart';

abstract class ISqliteConnector {
  Future<Database> getDatabaseInstance();
}
