import 'package:bierzaehler/domain/beverages/beverage.dart';
import 'package:bierzaehler/domain/beverages/i_beverage_repository.dart';
import 'package:bierzaehler/infrastructure/beverages/i_beverage_local_data_source.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

@LazySingleton(as: IBeverageRepository)
class BeverageRepository implements IBeverageRepository {
  BeverageRepository({@required this.localDataSource});

  final IBeverageLocalDataSource localDataSource;

  @override
  Future<List<Beverage>> getAllBeverages() {
    return localDataSource.getAllBeverages();
  }

  @override
  Future<Beverage> createNewBeverage(CreateBeverageParams params) {
    return localDataSource.createNewBeverage(params);
  }

  @override
  Future<Beverage> updateBeverage(UpdateBeverageParams params) {
    return localDataSource.updateBeverage(params);
  }
}
