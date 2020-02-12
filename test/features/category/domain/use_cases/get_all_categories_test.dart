import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/category/domain/entities/category.dart';
import 'package:bierzaehler/features/category/domain/repositories/category_repoitory.dart';
import 'package:bierzaehler/features/category/domain/use_cases/get_all_categories.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockCategoriesRepository extends Mock implements CategoryRepository{}

void main(){
  MockCategoriesRepository mockCategoriesRepository;
  GetAllCategories useCase;

  setUp((){
    mockCategoriesRepository = MockCategoriesRepository();
    useCase = GetAllCategories(mockCategoriesRepository);
  });

  const List<Category> tCategories = <Category>[
    Category(name: 'Bier', id: 1),
    Category(name: 'Wein', id: 2),
  ];

  group('getAllCategories', (){
    test('should get berverages from the repository', () async {
      when(mockCategoriesRepository.getAllCategories()).thenAnswer(
              (_) async => const Right<Failure, List<Category>>(tCategories));

      final Either<Failure, List<Category>> result = await useCase(NoParams());
      expect(result, const Right<Failure, List<Category>>(tCategories));
      verify(mockCategoriesRepository.getAllCategories());
      verifyNoMoreInteractions(mockCategoriesRepository);
    });
    test('should get failure from the repository', () async {
      when(mockCategoriesRepository.getAllCategories()).thenAnswer(
              (_) async => Left<Failure, List<Category>>(NoDataFailure()));

      final Either<Failure, List<Category>> result = await useCase(NoParams());
      expect(result, Left<Failure, List<Category>>(NoDataFailure()));
      verify(mockCategoriesRepository.getAllCategories());
      verifyNoMoreInteractions(mockCategoriesRepository);
    });
  });
}