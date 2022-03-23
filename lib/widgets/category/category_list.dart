import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

import '../../models/category_model.dart';
import 'category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
    required this.listCategories,
    required this.onDeletePressed,
  }) : super(key: key);

  final BuiltList<CategoryModel> listCategories;
  final Function(int categoryId) onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listCategories.length,
      itemBuilder: (context, index) {
        var category = listCategories[index];
        return CategoryItem(
          item: category,
          onDeleteCategory: (id) {
            onDeletePressed(id);
          },
        );
      },
    );
  }
}
