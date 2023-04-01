import '../interface/cqlbr.interface.dart';
import 'cqlbr.expression.serialize.dart';
import 'cqlbr.operators.dart';
import 'cqlbr.utils.dart';

part 'cqlbr.expression.and.dart';
part 'cqlbr.expression.func.dart';
part 'cqlbr.expression.ope.dart';
part 'cqlbr.expression.or.dart';

class CQLExpression extends ICQLExpression {
  late ICQLExpression? _left;
  late ICQLExpression? _right;
  late CQLExpressionOperation _operation;
  late CQLOperatorCompare _compare;
  late String _term;
  late CQLExpressionSerialize _serialize;

  CQLExpression() {
    clear();
    _serialize = CQLExpressionSerialize(expression: this);
  }

  @override
  ICQLExpression? get left => _left;
  @override
  set left(ICQLExpression? value) => _left = value;

  @override
  ICQLExpression? get right => _right;
  @override
  set right(ICQLExpression? value) => _right = value;

  @override
  CQLExpressionOperation get operation => _operation;
  @override
  set operation(CQLExpressionOperation value) => _operation = value;

  @override
  CQLOperatorCompare get compare => _compare;
  @override
  set compare(CQLOperatorCompare value) => _compare = value;

  @override
  dynamic get term => _term;
  @override
  set term(dynamic value) => _term = value;

  @override
  void clear() {
    _left = null;
    _right = null;
    _term = '';
    _operation = CQLExpressionOperation.eoNone;
    _compare = CQLOperatorCompare.fcNone;
  }

  @override
  bool isEmpty() {
    return ((_term.isEmpty) && (_operation == CQLExpressionOperation.eoNone));
  }

  @override
  void copyWith(ICQLExpression node) {
    _left = node.left;
    _right = node.right;
    _term = node.term;
    _operation = node.operation;
    _compare = node.compare;
  }

  @override
  T? serialize<T extends Object>([bool addParens = false]) {
    return _serialize.serialize<T>(addParens);
  }
}

class CQLCriteriaExpression implements ICQLCriteriaExpression {
  late ICQLExpression? _expression;
  late ICQLExpression _lastAnd;

  CQLCriteriaExpression();

  @override
  ICQLCriteriaExpression call(
      {ICQLExpression? expression, String expressionStr = ''}) {
    if (expression == null) {
      _expression = CQLExpression();
      if (expressionStr.isNotEmpty) {
        and(CQLOperator(value: expressionStr));
      }
    } else {
      _expression = expression;
      _lastAnd = _findRightmostAnd(expression);
    }

    return this;
  }

  set lastAnd(ICQLExpression? value) => _lastAnd = value!;

  ICQLExpression _findRightmostAnd(ICQLExpression value) {
    switch (value.operation) {
      case CQLExpressionOperation.eoNone:
        return _expression!;
      case CQLExpressionOperation.eoOr:
        return _expression!;
      default:
        return _findRightmostAnd(value.right!);
    }
  }

  @override
  ICQLExpression get expression => _expression!;

  @override
  ICQLCriteriaExpression and(ICQLOperator expression) {
    return andExt(expression);
  }

  @override
  ICQLCriteriaExpression func(dynamic expression) {
    return funcExt(expression);
  }

  @override
  ICQLCriteriaExpression ope(ICQLOperator expression) {
    return opeExt(expression);
  }

  @override
  ICQLCriteriaExpression or(ICQLOperator expression) {
    return orExt(expression);
  }

  @override
  T asResult<T extends Object>() => _expression!.serialize<T>()!;
}
