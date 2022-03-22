import 'package:flutter/material.dart';

import '../../models/category_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final CategoryModel item;

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
          IconData(item.iconCodePoint!, fontFamily: 'MaterialIcons'),
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          item.title!,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
        subtitle: Text(item.description!),
      ),
    );
  }
}
