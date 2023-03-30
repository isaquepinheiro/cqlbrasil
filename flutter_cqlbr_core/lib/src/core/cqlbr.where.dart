import '../interface/cqlbr.interface.dart';
import 'cqlbr.expression.dart';
import 'cqlbr.section.dart';
import 'cqlbr.utils.dart';

class CQLWhere extends CQLSection implements ICQLWhere {
  late final ICQLExpression _expression;

  CQLWhere() : super(name: 'Where') {
    _expression = CQLExpression();
  }

  @override
  ICQLExpression get expression => _expression;
  @override
  set expression(ICQLExpression value) => _expression = value;

  @override
  T serialize<T extends Object>() {
    return isEmpty()
        ? '' as T
        : Utils.instance.concat(['WHERE', _expression.serialize<T>()]) as T;
  }

  @override
  void clear() {
    _expression.clear();
  }

  @override
  bool isEmpty() {
    return _expression.isEmpty();
  }
}
