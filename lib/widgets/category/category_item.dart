import 'package:flutter/material.dart';

import '../../models/category_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.item,
    required this.onDeleteCategory,
  }) : super(key: key);

  final CategoryModel item;
  final Function(int categoryId) onDeleteCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          width: 1.0,
          style: BorderStyle.solid,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        onTap: () {},
        leading: Icon(
          IconData(item.iconCodePoint ?? Icons.error.codePoint,
              fontFamily: 'MaterialIcons'),
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          item.title ?? '',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
        subtitle: Text(item.description ?? ''),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).primaryColorLight,
          onPressed: () => onDeleteCategory(item.id!),
        ),
      ),
    );
  }
}
