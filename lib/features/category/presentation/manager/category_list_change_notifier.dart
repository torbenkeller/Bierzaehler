import 'package:bierzaehler/core/error/failures.dart';
import 'package:bierzaehler/core/use_cases/use_case.dart';
import 'package:bierzaehler/features/category/domain/entities/category.dart';
import 'package:bierzaehler/features/category/domain/use_cases/get_all_categories.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

enum LoadingStatus { loading, complete }

class CategoryListChangeNotifier with ChangeNotifier {
  CategoryListChangeNotifier({@required GetAllCategories getAllCategories})
      : _getAllCategories = getAllCategories {
    syncCategoriesList();
  }

  final GetAllCategories _getAllCategories;
  Either<Failure, List<Category>> _categoriesList;
  LoadingStatus _loadingStatus;

  Future<void> syncCategoriesList() async {
    _setLoadingStatus(LoadingStatus.loading);
    _categoriesList = await _getAllCategories(NoParams());
    _setLoadingStatus(LoadingStatus.complete);
  }

  void _setLoadingStatus(LoadingStatus value) {
    _loadingStatus = value;
    notifyListeners();
  }

  LoadingStatus get loadingStatus => _loadingStatus;

  Either<Failure, List<Category>> get categoriesList => _categoriesList;
}
