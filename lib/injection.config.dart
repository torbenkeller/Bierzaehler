// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'infrastructure/beverages/beverage_local_data_source.dart';
import 'infrastructure/beverages/beverage_repsository.dart';
import 'application/beverages/beverages_list_change_notifier.dart';
import 'application/category/category_list_change_notifier.dart';
import 'infrastructure/category/category_local_data_source.dart';
import 'infrastructure/category/category_repository.dart';
import 'application/drink/drink_list_cange_notifier.dart';
import 'infrastructure/drink/drink_local_data_source.dart';
import 'infrastructure/drink/drink_repository.dart';
import 'infrastructure/beverages/i_beverage_local_data_source.dart';
import 'domain/beverages/i_beverage_repository.dart';
import 'infrastructure/category/i_category_local_data_source.dart';
import 'domain/category/i_category_repoitory.dart';
import 'infrastructure/drink/i_drink_local_data_source.dart';
import 'domain/drink/i_drink_repository.dart';
import 'infrastructure/core/i_sqlite_connector.dart';
import 'infrastructure/core/sqlite_connector.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<IBeverageLocalDataSource>(() => BeverageLocalDataSource());
  gh.lazySingleton<IBeverageRepository>(() =>
      BeverageRepository(localDataSource: get<IBeverageLocalDataSource>()));
  gh.lazySingleton<ICategoryLocalDataSource>(() => CategoryLocalDataSource());
  gh.lazySingleton<ICategoryRepository>(() =>
      CategoryRepository(localDataSource: get<ICategoryLocalDataSource>()));
  gh.lazySingleton<IDrinkLocalDataSource>(() => DrinkLocalDataSource());
  gh.lazySingleton<IDrinkRepository>(
      () => DrinkRepository(localDataSource: get<IDrinkLocalDataSource>()));
  gh.lazySingleton<ISqliteConnector>(() => SqliteConnectorImpl());
  gh.factory<BeveragesListChangeNotifier>(
      () => BeveragesListChangeNotifier(get<IBeverageRepository>()));
  gh.factory<CategoryListChangeNotifier>(
      () => CategoryListChangeNotifier(get<ICategoryRepository>()));
  gh.factory<DrinkListChangeNotifier>(
      () => DrinkListChangeNotifier(get<IDrinkRepository>()));
  return get;
}
