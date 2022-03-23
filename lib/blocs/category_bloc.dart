import 'package:built_collection/built_collection.dart';
import 'package:rxdart/subjects.dart';

import '../db/services/category_service.dart';
import '../models/category_model.dart';

class CategoryBloc {
  final CategoryService categoryService;

  CategoryBloc(this.categoryService) {
    _getCategories();
  }

  // Getting list of categories
  _getCategories() {
    categoryService.getAllCategories().then((cats) {
      _categoryListController.sink.add(cats);
    }).catchError((err) {
      _categoryListController.sink.addError(err);
    });
  }

  final _categoryListController = BehaviorSubject<BuiltList<CategoryModel>>();
  Stream<BuiltList<CategoryModel>> get categoryListStream =>
      _categoryListController.stream;

  final _createCategoryController = BehaviorSubject<CategoryModel>();
  Stream<CategoryModel> get createCategoryStream =>
      _createCategoryController.stream;

  updateCreateCategory(CategoryModel category) =>
      _createCategoryController.sink.add(category);

  Future<int> createNewCategory(CategoryModel category) async {
    return await categoryService.createCategory(category);
  }

  Future<void> deleteCategory(int categoryId) async {
    await categoryService.deleteCategory(categoryId).then((value) {
      _getCategories();
    });
  }

  dispose() {
    _createCategoryController.close();
    _categoryListController.close();
  }
}
