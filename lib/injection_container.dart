import 'package:bierzaehler/core/platform/sqlite_connector_impl.dart';
import 'package:bierzaehler/features/beverage/data/data_sources/beverage_local_data_source.dart';
import 'package:bierzaehler/features/beverage/data/data_sources/beverage_local_data_source_impl.dart';
import 'package:bierzaehler/features/beverage/data/repositories/beverage_repsository_impl.dart';
import 'package:bierzaehler/features/beverage/domain/repositories/beverage_repository.dart';
import 'package:bierzaehler/features/beverage/domain/use_cases/create_new_beverage.dart';
import 'package:bierzaehler/features/beverage/domain/use_cases/get_all_beverages.dart';
import 'package:bierzaehler/features/beverage/domain/use_cases/update_beverage.dart';
import 'package:bierzaehler/features/beverage/presentation/manager/beverages_list_change_notifier.dart';
import 'package:bierzaehler/features/category/data/data_sources/category_local_data_source.dart';
import 'package:bierzaehler/features/category/data/data_sources/category_local_data_source_impl.dart';
import 'package:bierzaehler/features/category/data/repositories/category_repository_impl.dart';
import 'package:bierzaehler/features/category/domain/repositories/category_repoitory.dart';
import 'package:bierzaehler/features/category/domain/use_cases/get_all_categories.dart';
import 'package:bierzaehler/features/category/presentation/manager/category_list_change_notifier.dart';
import 'package:bierzaehler/features/drink/data/data_sources/drink_local_data_source.dart';
import 'package:bierzaehler/features/drink/data/data_sources/drink_local_data_source_impl.dart';
import 'package:bierzaehler/features/drink/data/repositories/drink_repository_impl.dart';
import 'package:bierzaehler/features/drink/domain/repositories/drink_repository.dart';
import 'package:bierzaehler/features/drink/domain/use_cases/create_new_drink.dart';
import 'package:bierzaehler/features/drink/domain/use_cases/get_all_drinks_for_beverage.dart';
import 'package:bierzaehler/features/drink/presentation/manager/drink_list_cange_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerSingleton(SqliteConnectorImpl(databaseFactory: databaseFactory));

  final Database database =
      await sl<SqliteConnectorImpl>().getDatabaseInstance();
  // Data Sources
  sl.registerLazySingleton<BeverageLocalDataSource>(
      () => BeverageLocalDataSourceImpl(database));
  sl.registerLazySingleton<CategoryLocalDataSource>(
      () => CategoryLocalDataSourceImpl(database));
  sl.registerLazySingleton<DrinkLocalDataSource>(
      () => DrinkLocalDataSourceImpl(database));

  //Repositories
  sl.registerLazySingleton<BeverageRepository>(() =>
      BeverageRepositoryImpl(localDataSource: sl<BeverageLocalDataSource>()));
  sl.registerLazySingleton<CategoryRepository>(() =>
      CategoryRepositoryImpl(localDataSource: sl<CategoryLocalDataSource>()));
  sl.registerLazySingleton<DrinkRepository>(
      () => DrinkRepositoryImpl(localDataSource: sl<DrinkLocalDataSource>()));

  // Use cases
  sl.registerLazySingleton<GetAllBeverages>(
      () => GetAllBeverages(sl<BeverageRepository>()));
  sl.registerLazySingleton<CreateNewBeverage>(
      () => CreateNewBeverage(sl<BeverageRepository>()));
  sl.registerLazySingleton<UpdateBeverage>(
      () => UpdateBeverage(sl<BeverageRepository>()));
  sl.registerLazySingleton<GetAllCategories>(
      () => GetAllCategories(sl<CategoryRepository>()));
  sl.registerLazySingleton<GetAllDrinksForBeverage>(
      () => GetAllDrinksForBeverage(sl<DrinkRepository>()));
  sl.registerLazySingleton<CreateNewDrink>(
      () => CreateNewDrink(sl<DrinkRepository>()));

  // Managers
  sl.registerFactory<BeveragesListChangeNotifier>(
      () => BeveragesListChangeNotifier(
            getAllBeverages: sl<GetAllBeverages>(),
            createNewBeverage: sl<CreateNewBeverage>(),
            updateBeverage: sl<UpdateBeverage>(),
          ));
  sl.registerFactory<CategoryListChangeNotifier>(() =>
      CategoryListChangeNotifier(getAllCategories: sl<GetAllCategories>()));
  sl.registerFactory<DrinkListChangeNotifier>(() => DrinkListChangeNotifier(
        getAllDrinksForBeverage: sl<GetAllDrinksForBeverage>(),
        createNewDrink: sl<CreateNewDrink>(),
      ));
}
