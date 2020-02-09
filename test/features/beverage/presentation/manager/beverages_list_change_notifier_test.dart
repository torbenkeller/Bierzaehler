import 'dart:ui';

import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:bierzaehler/features/beverage/domain/use_cases/create_new_beverage.dart';
import 'package:bierzaehler/features/beverage/domain/use_cases/get_all_beverages.dart';
import 'package:bierzaehler/features/beverage/presentation/manager/beverages_list_change_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:equatable/equatable.dart' as eq;

import '../../../../core/platform/notifier_tester.dart';

class MockGetAllBeverages extends Mock implements GetAllBeverages {}

class MockCreateNewBeverage extends Mock implements CreateNewBeverage {}

void main() {
  MockGetAllBeverages mockGetAllBeverages;
  MockCreateNewBeverage mockCreateNewBeverage;
  BeveragesListChangeNotifier beveragesListChangeNotifier;

  setUp(() {
    mockGetAllBeverages = MockGetAllBeverages();
    mockCreateNewBeverage = MockCreateNewBeverage();
    beveragesListChangeNotifier = BeveragesListChangeNotifier(
        getAllBeverages: mockGetAllBeverages,
        createNewBeverage: mockCreateNewBeverage);
  });

  group('getAllBeverages', () {
    const List<Beverage> tBeverages = <Beverage>[
      Beverage(
        beverageID: 1,
        categoryID: 1,
        name: 'Jever',
        color: Color(0xff7b1fa2),
        alcohol: 0.049,
        category: 'Bier',
        totalDrinkCount: 12,
      )
    ];
    test('test successful data request', () async {
      when(mockGetAllBeverages(NoParams())).thenAnswer(
          (_) async => const Right<Failure, List<Beverage>>(tBeverages));

      await expectNotifyListenerCalls(
          beveragesListChangeNotifier,
          beveragesListChangeNotifier.syncBeverageList,
          (BeveragesListChangeNotifier notifier) => notifier.loadingStatus,
          <LoadingStatus>[LoadingStatus.loading, LoadingStatus.complete]);

      expect(beveragesListChangeNotifier.beverageList,
          const Right<Failure, List<Beverage>>(tBeverages));
    });

    test('test Failure', () async {
      when(mockGetAllBeverages(NoParams())).thenAnswer(
          (_) async => Left<Failure, List<Beverage>>(NoDataFailure()));

      await expectNotifyListenerCalls(
          beveragesListChangeNotifier,
          beveragesListChangeNotifier.syncBeverageList,
          (BeveragesListChangeNotifier notifier) => notifier.loadingStatus,
          <LoadingStatus>[LoadingStatus.loading, LoadingStatus.complete]);

      expect(beveragesListChangeNotifier.beverageList,
          Left<Failure, List<Beverage>>(NoDataFailure()));
    });
  });

  group('createNewBeverage', () {
    const List<Beverage> tBeverage = <Beverage>[
      Beverage(
        beverageID: 1,
        categoryID: 1,
        name: 'Jever',
        color: Color(0xff7b1fa2),
        alcohol: 0.049,
        category: 'Bier',
        totalDrinkCount: 12,
      )
    ];

    test('test succsessful insert', () async {
      when(mockCreateNewBeverage(any))
          .thenAnswer((_) async => Right<Failure, Beverage>(tBeverage[0]));

      final bool result = await beveragesListChangeNotifier.createNewBeverage(
          const CreateBeverageParams(
              categoryName: 'Bier',
              name: 'Jever',
              alcohol: 0.049,
              color: 0xff7b1fa2));
      expect(result, true);
      expect(
          (beveragesListChangeNotifier.beverageList.getOrElse(() => null))
              .every((Beverage b) => tBeverage.contains(b)),
          true);
    });
  });
}
