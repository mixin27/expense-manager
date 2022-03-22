import 'package:built_collection/built_collection.dart';
import 'package:expense_manager/db/offline_db_provider.dart';
import 'package:expense_manager/models/serializer.dart';

import '../../models/category_model.dart';

abstract class CategoryService {
  Future<BuiltList<CategoryModel>> getAllCategories();
  Future<int> createCategory(CategoryModel category);
}

class CategoryServiceImpl implements CategoryService {
  @override
  Future<int> createCategory(CategoryModel category) async {
    // check if exists already
    var exists = await categoryExists(category.title!);

    if (exists) return 0;

    var db = await OfflineDbProvider.provider.database;

    // get the biggest id in the table
    // var table = await db.rawQuery("SELECT MAX(id) as id FROM Category");
    // int? maxId = table.first["id"] as int;

    var resultId = await db.rawInsert(
      "INSERT INTO Category (title, description, iconCodePoint) VALUES (?,?,?)",
      [category.title, category.description, category.iconCodePoint],
    );

    return resultId;
  }

  Future<bool> categoryExists(String title) async {
    var db = await OfflineDbProvider.provider.database;
    var res = await db.query("Category");

    if (res.isEmpty) return false;

    var entity = res.firstWhere((element) => element["title"] == title);
    return entity.isNotEmpty;
  }

  @override
  Future<BuiltList<CategoryModel>> getAllCategories() async {
    var db = await OfflineDbProvider.provider.database;
    var res = await db.query('Category');

    if (res.isEmpty) return BuiltList();

    var list = BuiltList<CategoryModel>();
    for (var element in res) {
      var category = serializers.deserializeWith<CategoryModel>(
          CategoryModel.serializer, element);
      list = list.rebuild((b) => b..add(category!));
    }

    return list.rebuild(
      (b) => b
        ..sort(
          (a, b) => a.title!.compareTo(b.title!),
        ),
    );
  }
}
