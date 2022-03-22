import 'package:expense_manager/routes/add_category.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../widgets/category/category_list.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final List<CategoryModel> _listCategories = <CategoryModel>[];

  @override
  void initState() {
    super.initState();
    _initCategories();
  }

  _initCategories() {
    var cat1 = CategoryModel().rebuild(
      (b) => b
        ..id = 0
        ..title = 'Home Utils'
        ..description = 'Home utilities related expenses'
        ..iconCodePoint = Icons.home.codePoint,
    );
    _listCategories.add(cat1);

    var cat2 = CategoryModel().rebuild(
      (b) => b
        ..id = 0
        ..title = "Grocery"
        ..description = "Grocery related expenses"
        ..iconCodePoint = Icons.local_grocery_store.codePoint,
    );
    _listCategories.add(cat2);

    var cat3 = CategoryModel().rebuild(
      (b) => b
        ..id = 0
        ..title = "Food"
        ..description = "Food related expenses"
        ..iconCodePoint = Icons.fastfood.codePoint,
    );
    _listCategories.add(cat3);

    var cat4 = CategoryModel().rebuild(
      (b) => b
        ..id = 0
        ..title = "Auto"
        ..description = "Car/Bike related expenses"
        ..iconCodePoint = Icons.directions_bike.codePoint,
    );
    _listCategories.add(cat4);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          width: 200.0,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCategory(),
                ),
              );
            },
            child: const Text('Add New'),
          ),
        ),
        Expanded(
          child: CategoryList(
            list: _listCategories,
          ),
        ),
      ],
    );
  }
}
