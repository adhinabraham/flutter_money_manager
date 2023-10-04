import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/category/category_model.dart';

const CATEGORY_DB_NAME = "Category-database";

abstract class CategoryDbFunction {
  Future<List<CategoryModel>> getCategory();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String value);
}

class CategoryDB implements CategoryDbFunction {
  CategoryDB._internal();

  static CategoryDB instance = CategoryDB._internal();

  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryList = ValueNotifier([]);

  @override
  Future<List<CategoryModel>> getCategory() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id, value);
    refreshUI();
  }

  Future<void> refreshUI() async {
    final _allCategory = await getCategory();
    incomeCategoryList.value.clear();
    expenseCategoryList.value.clear();
    await Future.forEach(
        _allCategory,
        (category) => {
              if (category.type == CategoryType.income){
                incomeCategoryList.value.add(category),
              } else {
                expenseCategoryList.value.add(category),
              }
            });
    incomeCategoryList.notifyListeners();
    expenseCategoryList.notifyListeners();
  }

  @override
  Future<void> deleteCategory( String CategoryId) async {
    print("kjkjkjkjkjk $CategoryId");
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _categoryDB.delete(CategoryId);
    refreshUI();
  }
}
