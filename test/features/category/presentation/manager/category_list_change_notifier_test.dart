import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/domain/category/category.dart';
import 'package:bierzaehler/features/category/domain/use_cases/get_all_categories.dart';
import 'package:bierzaehler/application/category/category_list_change_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/platform/notifier_tester.dart';

class MockGetAllCategories extends Mock implements GetAllCategories {}

void main() {
  MockGetAllCategories mockGetAllCategories;
  CategoryListChangeNotifier categoryListChangeNotifier;

  setUp(() {
    mockGetAllCategories = MockGetAllCategories();
    categoryListChangeNotifier =
        CategoryListChangeNotifier(getAllCategories: mockGetAllCategories);
  });

  group('syncCategoriesList', () {
    const List<Category> tCategories = <Category>[
      Category(id: 1, name: 'Bier'),
      Category(id: 2, name: 'Wein'),
    ];
    test('test successful data request', () async {
      when(mockGetAllCategories(NoParams())).thenAnswer(
          (_) async => const Right<Failure, List<Category>>(tCategories));

      await expectNotifyListenerCalls(
          categoryListChangeNotifier,
          categoryListChangeNotifier.syncCategoriesList,
          (CategoryListChangeNotifier notifier) => notifier.loadingStatus,
          <LoadingStatus>[LoadingStatus.loading, LoadingStatus.complete]);

      expect(categoryListChangeNotifier.categoriesList,
          const Right<Failure, List<Category>>(tCategories));
    });

    test('test Failure', () async {
      when(mockGetAllCategories(NoParams())).thenAnswer(
          (_) async => Left<Failure, List<Category>>(NoDataFailure()));

      await expectNotifyListenerCalls(
          categoryListChangeNotifier,
          categoryListChangeNotifier.syncCategoriesList,
          (CategoryListChangeNotifier notifier) => notifier.loadingStatus,
          <LoadingStatus>[LoadingStatus.loading, LoadingStatus.complete]);

      expect(categoryListChangeNotifier.categoriesList,
          Left<Failure, List<Category>>(NoDataFailure()));
    });
  });
}
