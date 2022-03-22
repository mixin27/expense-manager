import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'category_model.g.dart';

abstract class CategoryModel
    implements Built<CategoryModel, CategoryModelBuilder> {
  CategoryModel._();
  factory CategoryModel([void Function(CategoryModelBuilder) updates]) =
      _$CategoryModel;
  static Serializer<CategoryModel> get serializer => _$categoryModelSerializer;

  int? get id;
  String? get title;
  String? get description;
  int? get iconCodePoint;
}
