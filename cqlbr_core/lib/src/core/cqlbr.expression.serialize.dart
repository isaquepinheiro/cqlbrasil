import '../interface/cqlbr.interface.dart';
import 'cqlbr.utils.dart';

class CQLExpressionSerialize {
  late final ICQLExpression expression;
  
  CQLExpressionSerialize({
    required this.expression,
  });

  T? serialize<T extends Object>([bool addParens = false]) {
    if (expression.isEmpty()) {
      return '' as T;
    }
    switch (expression.operation) {
      case CQLExpressionOperation.eoNone:
        return _serializeWhere(addParens) as T;
      case CQLExpressionOperation.eoAnd:
        return _serializeAND() as T;
      case CQLExpressionOperation.eoOr:
        return _serializeOR() as T;
      case CQLExpressionOperation.eoOperation:
        return _serializeOperator() as T;
      case CQLExpressionOperation.eoFunction:
        return _serializeFunction() as T;
      default:
        throw Exception(
            'CQLExpression.Serialize: Unknown expression operation: $expression.operation');
    }
  }

  String _serializeWhere(bool addParens) {
    return addParens
        ? '(${expression.term})'
        : expression.term;
  }

  String _serializeAND() {
    return Utils.instance.concat([
      expression.left?.serialize(true),
      'AND',
      expression.right?.serialize(true)
    ]);
  }

  String _serializeOR() {
    final String result = Utils.instance.concat([
      expression.left?.serialize(true),
      'OR',
      expression.right?.serialize(true)
    ]);

    return '($result)';
  }

  String _serializeOperator() {
    final result = Utils.instance.concat([
      expression.left?.serialize(),
      expression.compare.name,
      expression.right?.serialize()
    ]);

    return '($result)';
  }

  String _serializeFunction() {
    return Utils.instance.concat([
      expression.left!.serialize(),
      expression.right!.serialize()
    ]);
  }
}
