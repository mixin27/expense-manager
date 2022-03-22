import 'package:built_collection/built_collection.dart';

import '../blocs/category_bloc.dart';
import '../db/services/category_service.dart';
import '../routes/add_category.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';
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
    _categoryBloc = CategoryBloc(CategoryServiceImpl());
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
        StreamBuilder(
          stream: _categoryBloc.categoryListStream,
          builder: (context, AsyncSnapshot<BuiltList<CategoryModel>> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();

            final listCategories = snapshot.data!;

            return Expanded(
              child: CategoryList(
                list: listCategories,
              ),
            );
          },
        ),
      ],
    );
  }
}
