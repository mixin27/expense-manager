import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:expense_manager/db/services/category_service.dart';
import 'package:flutter/material.dart';

import '../blocs/category_bloc.dart';
import '../models/category_model.dart';
import '../routes/add_category.dart';
import '../widgets/category/category_list.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late CategoryBloc _categoryBloc;

  @override
  void initState() {
    super.initState();
    initCategoryBloc();
  }

  FutureOr onGoBack(dynamic value) {
    initCategoryBloc();
    setState(() {});
  }

  initCategoryBloc() {
    _categoryBloc = CategoryBloc(CategoryServiceImpl());
  }

  @override
  void dispose() {
    super.dispose();
    _categoryBloc.dispose();
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
                  builder: (context) => AddCategory(
                    categoryBloc: _categoryBloc,
                  ),
                ),
              ).then(onGoBack);
            },
            child: const Text('Add New'),
          ),
        ),
        StreamBuilder(
          stream: _categoryBloc.categoryListStream,
          builder: (context, AsyncSnapshot<BuiltList<CategoryModel>> snapshot) {
            if (!snapshot.hasData) return const Text('No category data found.');

            final listCategories = snapshot.data!;

            return Expanded(
              child: CategoryList(
                listCategories: listCategories,
                onDeletePressed: (categoryId) =>
                    _categoryBloc.deleteCategory(categoryId),
              ),
            );
          },
        ),
      ],
    );
  }
}
