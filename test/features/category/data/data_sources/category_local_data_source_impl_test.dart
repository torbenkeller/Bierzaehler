import 'dart:convert';

import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/features/category/data/data_sources/category_local_data_source_impl.dart';
import 'package:bierzaehler/features/category/data/models/category_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/src/exception.dart';
import 'package:collection/collection.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  CategoryLocalDataSourceImpl dataSource;
  MockDatabase mockDatabase;

  setUp(() {
    mockDatabase = MockDatabase();
    dataSource = CategoryLocalDataSourceImpl(mockDatabase);
  });

  group('getAllBeverages', () {
    final List<Map<String, dynamic>> tData =
        (json.decode(fixture('categories_list_regular.json')) as List<dynamic>)
            .map((dynamic item) => item as Map<String, dynamic>)
            .toList();
    test('should return the list of beverages', () async {
      const List<CategoryModel> tCategories = <CategoryModel>[
        CategoryModel(name: 'Bier', catID: 1),
        CategoryModel(name: 'Wein', catID: 2),
      ];
      when(mockDatabase.rawQuery(any)).thenAnswer((_) async => tData);

      final List<CategoryModel> list = await dataSource.getAllCategories();
      final bool isAsExpected = const DeepCollectionEquality().equals(
          list.map((CategoryModel c) => c.toJson()),
          tCategories.map((CategoryModel c) => c.toJson()));

      verify(mockDatabase.rawQuery(any));
      verifyNoMoreInteractions(mockDatabase);

      expect(isAsExpected, true);
    });

    test('should throw exceptions upwords', () async {
      when(mockDatabase.rawQuery(any)).thenThrow(SqfliteDatabaseException(
          'SQL Error', <String, String>{'sql': 'The wrong sql'}));
      try {
        await dataSource.getAllCategories();
      } catch (e) {
        expect(e, isInstanceOf<SqlFailure>());
      }
    });
  });
}
