import 'package:bierzaehler/core/platform/sqlite_connector_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

class MockDatabaseFactory extends Mock implements DatabaseFactory {}

class MockDatabase extends Mock implements Database {}

void main() {
  MockDatabaseFactory mockDatabaseFactory;
  SqliteConnectorImpl sqliteConnectorImpl;

  setUp(() {
    mockDatabaseFactory = MockDatabaseFactory();
    sqliteConnectorImpl =
        SqliteConnectorImpl(databaseFactory: mockDatabaseFactory);
  });

  final tMockDatabase = MockDatabase();

  group('open Database correctly', () {
    test('should return the database', () async {
      when(mockDatabaseFactory.openDatabase('path/Bierzaehler.db',
              options: anyNamed('options')))
          .thenAnswer((_) async => tMockDatabase);

      when(mockDatabaseFactory.getDatabasesPath())
          .thenAnswer((_) async => 'path/');

      final result = await sqliteConnectorImpl.getDatabaseInstance();

      verify(mockDatabaseFactory.getDatabasesPath());
      verify(mockDatabaseFactory.openDatabase('path/Bierzaehler.db',
          options: anyNamed('options')));
      verifyNoMoreInteractions(mockDatabaseFactory);

      expect(result, tMockDatabase);
    });

  });
}
