import 'dart:ui';

import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/beverage/domain/entities/beverage.dart';
import 'package:bierzaehler/features/beverage/domain/use_cases/create_new_beverage.dart';
import 'package:bierzaehler/features/beverage/domain/use_cases/get_all_beverages.dart';
import 'package:bierzaehler/features/beverage/domain/use_cases/update_beverage.dart';
import 'package:bierzaehler/features/beverage/presentation/manager/beverages_list_change_notifier.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../core/platform/notifier_tester.dart';

class MockGetAllBeverages extends Mock implements GetAllBeverages {}

class MockCreateNewBeverage extends Mock implements CreateNewBeverage {}

class MockUpdateBeverage extends Mock implements UpdateBeverage {}

void main() {
  MockGetAllBeverages mockGetAllBeverages;
  MockCreateNewBeverage mockCreateNewBeverage;
  MockUpdateBeverage mockUpdateBeverage;
  BeveragesListChangeNotifier beveragesListChangeNotifier;

  setUp(() {
    mockGetAllBeverages = MockGetAllBeverages();
    mockCreateNewBeverage = MockCreateNewBeverage();
    mockUpdateBeverage = MockUpdateBeverage();
    beveragesListChangeNotifier = BeveragesListChangeNotifier(
      getAllBeverages: mockGetAllBeverages,
      createNewBeverage: mockCreateNewBeverage,
      updateBeverage: mockUpdateBeverage,
    );
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
    test('test insert failed', () async {
      when(mockCreateNewBeverage(any))
          .thenAnswer((_) async => Left<Failure, Beverage>(ArgumentFailure()));

      final bool result = await beveragesListChangeNotifier.createNewBeverage(
          const CreateBeverageParams(
              categoryName: 'Bier',
              name: 'Jever',
              alcohol: 0.049,
              color: 0xff7b1fa2));
      expect(result, false);
      expect(
          beveragesListChangeNotifier.beverageList?.getOrElse(
            () => null,
          ),
          null);
    });
  });

  group('updateBeverage', () {
    const Beverage tBeverageNew = Beverage(
      beverageID: 1,
      categoryID: 1,
      name: 'Jever',
      color: Color(0xff7b1fa2),
      alcohol: 0.049,
      category: 'Bier',
      totalDrinkCount: 12,
    );

    const Beverage tBeverageOld = Beverage(
      beverageID: 1,
      categoryID: 2,
      name: 'Riesling',
      color: Color(0x00000000),
      alcohol: 0.12,
      category: 'Wein',
      totalDrinkCount: 12,
    );

    const UpdateBeverageParams params = UpdateBeverageParams(
      old: Beverage(
        beverageID: 1,
        categoryID: 2,
        name: 'Riesling',
        color: Color(0x00000000),
        alcohol: 0.15,
        category: 'Wein',
        totalDrinkCount: 12,
      ),
      newName: 'Jever',
      newAlcohol: 0.049,
      newColor: 0xff7b1fa2,
      newCategoryName: 'Bier',
    );

    test('test successful update', () async {
      when(mockUpdateBeverage(params)).thenAnswer(
          (_) async => const Right<Failure, Beverage>(tBeverageNew));
      when(mockGetAllBeverages(any)).thenAnswer((_) async =>
          const Right<Failure, List<Beverage>>(<Beverage>[tBeverageOld]));
      await beveragesListChangeNotifier.syncBeverageList();
      final bool result =
          await beveragesListChangeNotifier.updateBeverage(params);
      expect(result, isTrue);

      final List<Beverage> newList =
          beveragesListChangeNotifier.beverageList.getOrElse(() => null);
      expect(newList.isNotEmpty, isTrue);
      expect(newList[0], tBeverageNew);
    });

    test('test update failed', ()async{
      when(mockUpdateBeverage(params)).thenAnswer(
              (_) async => Left<Failure, Beverage>(ArgumentFailure()));
      when(mockGetAllBeverages(any)).thenAnswer((_) async =>
      const Right<Failure, List<Beverage>>(<Beverage>[tBeverageOld]));
      await beveragesListChangeNotifier.syncBeverageList();
      final bool result =
      await beveragesListChangeNotifier.updateBeverage(params);
      expect(result, isFalse);

      final List<Beverage> newList =
      beveragesListChangeNotifier.beverageList.getOrElse(() => null);
      expect(newList.isNotEmpty, isTrue);
      expect(newList[0], tBeverageOld);
    });
  });
}
