import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/infrastructure/category/i_category_local_data_source.dart';
import 'package:bierzaehler/infrastructure/category/category_model.dart';
import 'package:bierzaehler/infrastructure/category/category_repository.dart';
import 'package:bierzaehler/domain/category/category.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCategoryLocalDataSource extends Mock
    implements ICategoryLocalDataSource {}

void main() {
  MockCategoryLocalDataSource mockLocalDataSource;
  CategoryRepository repository;

  setUp(() {
    mockLocalDataSource = MockCategoryLocalDataSource();
    repository =
        CategoryRepository(localDataSource: mockLocalDataSource);
  });

  const List<CategoryModel> tCategories = <CategoryModel>[
    CategoryModel(name: 'Bier', catID: 1),
    CategoryModel(name: 'Wein', catID: 2),
  ];

  group('getAllcategories', () {
    test('should return all Beverages', () async {
      when(mockLocalDataSource.getAllCategories())
          .thenAnswer((_) async => tCategories);

      final Either<Failure, List<Category>> result =
          await repository.getAllCategories();
      verify(mockLocalDataSource.getAllCategories());
      expect(result, const Right<Failure, List<CategoryModel>>(tCategories));
    });

    test('shoult return NoDataFailure when there is no data selected',
        () async {
      when(mockLocalDataSource.getAllCategories()).thenAnswer(
          (_) => Future<List<CategoryModel>>.error(NoDataFailure()));

      final Either<Failure, List<Category>> result =
          await repository.getAllCategories();
      verify(mockLocalDataSource.getAllCategories());
      expect(result, Left<Failure, List<CategoryModel>>(NoDataFailure()));
    });
  });
}
