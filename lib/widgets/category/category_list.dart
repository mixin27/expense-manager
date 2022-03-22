import 'package:expense_manager/models/category_model.dart';
import 'package:expense_manager/widgets/category/category_item.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<CategoryModel> list;

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
