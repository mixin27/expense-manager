import 'package:flutter/material.dart';

import '../blocs/category_bloc.dart';
import '../models/category_model.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({
    Key? key,
    required this.categoryBloc,
  }) : super(key: key);

  final CategoryBloc categoryBloc;

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  @override
  void initState() {
    super.initState();
    widget.categoryBloc.updateCreateCategory(CategoryModel());
  }

  @override
  void dispose() {
    super.dispose();
    widget.categoryBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Category'),
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder(
          stream: widget.categoryBloc.createCategoryStream,
          builder: (context, AsyncSnapshot<CategoryModel?> snapshot) {
            return Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                  ),
                  onChanged: (value) {
                    if (value.trim() == "") return;

                    var category = snapshot.data!;
                    var updated = category.rebuild((b) => b..title = value);
                    widget.categoryBloc.updateCreateCategory(updated);
                  },
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 2,
                  onChanged: (value) {
                    if (value.trim() == "") return;

                    var category = snapshot.data!;
                    var updated =
                        category.rebuild((b) => b..description = value);
                    widget.categoryBloc.updateCreateCategory(updated);
                  },
                ),
                Container(
                  margin: const EdgeInsets.all(12.0),
                  child: const Text(
                    "PICKE AN ICON",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: _showIconGrid(snapshot.data),
                  ),
                ),
                ElevatedButton(
                  onPressed: snapshot.data?.title == null
                      ? null
                      : () async {
                          var createdId = await widget.categoryBloc
                              .createNewCategory(snapshot.data!);

                          if (createdId > 0) {
                            Navigator.of(context).pop();
                          } else {
                            // showSnackBar(
                            //   context,
                            //   const SnackBar(
                            //     content: Text('Error on creating Category.'),
                            //   ),
                            // );
                            // show error
                          }
                        },
                  child: const Text('CREATE CATEGORY'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _showIconGrid(CategoryModel? category) {
    var listIcon = [
      Icons.web_asset,
      Icons.weekend,
      Icons.whatshot,
      Icons.widgets,
      Icons.wifi,
      Icons.wifi_lock,
      Icons.wifi_tethering,
      Icons.work,
      Icons.wrap_text,
      Icons.youtube_searched_for,
      Icons.zoom_in,
      Icons.zoom_out,
      Icons.zoom_out_map,
      Icons.restaurant_menu,
      Icons.restore,
      Icons.restore_from_trash,
      Icons.restore_page,
      Icons.ring_volume,
      Icons.room,
      Icons.exposure_zero,
      Icons.extension,
      Icons.face,
      Icons.fast_forward,
      Icons.fast_rewind,
      Icons.fastfood,
      Icons.favorite,
      Icons.favorite_border,
      Icons.emoji_transportation,
    ];

    return GridView.count(
      crossAxisCount: 8,
      children: List.generate(listIcon.length, (index) {
        var iconData = listIcon[index];
        return IconButton(
          onPressed: () {
            var updated =
                category?.rebuild((b) => b..iconCodePoint = iconData.codePoint);
            widget.categoryBloc.updateCreateCategory(updated!);
          },
          icon: Icon(
            iconData,
            size: 35,
          ),
          color: category?.iconCodePoint == null
              ? null
              : category?.iconCodePoint == iconData.codePoint
                  ? Colors.yellowAccent
                  : null,
        );
      }),
    );
  }
}
