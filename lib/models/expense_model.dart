import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'expense_model.g.dart';

abstract class ExpenseModel
    implements Built<ExpenseModel, ExpenseModelBuilder> {
  // Fields

  ExpenseModel._();

  factory ExpenseModel([void Function(ExpenseModelBuilder) updates]) =
      _$ExpenseModel;

  static Serializer<ExpenseModel> get serializer => _$expenseModelSerializer;

  int? get id;
  int? get categoryId;
  String? get title;
  String? get notes;
  double? get amount;
}
