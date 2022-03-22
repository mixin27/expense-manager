import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';

import '../../models/category_model.dart';
import 'category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
    required this.list,
  }) : super(key: key);

  final BuiltList<CategoryModel> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        var category = list[index];
        return CategoryItem(
          item: category,
        );
      },
    );
  }
}
