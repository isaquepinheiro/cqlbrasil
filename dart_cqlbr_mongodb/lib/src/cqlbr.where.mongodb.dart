import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';

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
  T? serialize<T extends Object>() {
    return isEmpty()
        ? null
        : Utils.instance
            .concat(['{', _expression.serialize(), '}'], delimiter: '') as T;
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
