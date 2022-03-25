import 'package:built_collection/built_collection.dart';
import 'package:expense_manager/blocs/category_bloc.dart';
import 'package:expense_manager/db/services/category_service.dart';
import 'package:expense_manager/utils/constants.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  CategoryBloc? _categoryBloc;
  FocusNode _focus = FocusNode();
  bool _showKeyboard = false;
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _categoryBloc = CategoryBloc(CategoryServiceImpl());
    _focus.addListener(_onFocusChanged);
  }

  void _onFocusChanged() {
    setState(() {
      _showKeyboard = _focus.hasFocus;
    });
  }

  int _selectedCategoryId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAddExpenseTitle),
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                'Pick Category',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: StreamBuilder(
                stream: _categoryBloc!.categoryListStream,
                builder: (_, AsyncSnapshot<BuiltList<CategoryModel>> snap) {
                  if (!snap.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Wrap(
                    children: List.generate(
                      snap.data!.length,
                      (index) {
                        var categoryModel = snap.data![index];
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: ChoiceChip(
                            selectedColor:
                                Theme.of(context).colorScheme.secondary,
                            label: Text(categoryModel.title ?? ''),
                            selected: categoryModel.id! == _selectedCategoryId,
                            onSelected: (selected) {
                              setState(() {
                                _selectedCategoryId = categoryModel.id!;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 12.0),
                      child: TextField(
                        controller: _amountController,
                        focusNode: _focus,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Amount',
                        ),
                        maxLines: 1,
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  _shortcutKeyboard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shortcutKeyboard() {
    var keyboardKeys = [
      "50",
      "100",
      "500",
      "1000",
      "1500",
      "3000",
      "5000",
    ];

    return Container(
      height: 53.0,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: keyboardKeys.length,
        itemBuilder: (context, index) {
          var key = keyboardKeys[index];

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: TextButton(
              onPressed: () {
                setState(() {
                  _amountController.value = _amountController.value.copyWith(
                    text: key,
                    selection: TextSelection.collapsed(
                      offset: key.length,
                    ),
                  );
                });
              },
              child: Text(key),
            ),
          );
        },
      ),
    );
  }
}
