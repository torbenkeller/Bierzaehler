import 'package:bierzaehler/domain/category/category.dart';
import 'package:bierzaehler/domain/category/i_category_repoitory.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

enum LoadingStatus { loading, complete }

@Injectable()
class CategoryListChangeNotifier with ChangeNotifier {
  CategoryListChangeNotifier(this._categoryRepository) {
    syncCategoriesList();
  }

  final ICategoryRepository _categoryRepository;
  List<Category> _categoriesList;
  LoadingStatus _loadingStatus;

  Future<void> syncCategoriesList() async {
    _setLoadingStatus(LoadingStatus.loading);
    try {
      _categoriesList = await _categoryRepository.getAllCategories();
    } catch (e) {
      _categoriesList = [];
      print(e);
    }
    _setLoadingStatus(LoadingStatus.complete);
  }

  void _setLoadingStatus(LoadingStatus value) {
    _loadingStatus = value;
    notifyListeners();
  }

  LoadingStatus get loadingStatus => _loadingStatus;

  List<Category> get categoriesList => List.unmodifiable(_categoriesList ?? []);
}
