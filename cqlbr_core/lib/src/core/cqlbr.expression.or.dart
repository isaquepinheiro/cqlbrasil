part of 'cqlbr.expression.dart';

extension CQLCriteriaExpressionOr on CQLCriteriaExpression {
  ICQLCriteriaExpression orExt(ICQLOperator oper) {
    if (oper.value is List<String>) {
      return _orList(oper);
    } else if (oper.value is String) {
      return _orString(oper);
    } else {
      return _orInterface(oper.value);
    }
  }

  ICQLCriteriaExpression _orList(ICQLOperator oper) {
    final List<String> list = oper.value;
    oper.value = Utils.instance.sqlParamsToStr(list);

    return _orString(oper);
  }

  ICQLCriteriaExpression _orString(ICQLOperator oper) {
    final ICQLExpression node = CQLExpression();
    node.term = oper.value;
    node.compare = oper.compare;

    return _orInterface(node);
  }

  ICQLCriteriaExpression _orInterface(ICQLExpression expr) {
    final ICQLExpression root = _lastAnd;
    final ICQLExpression node = CQLExpression();

    node.copyWith(root);
    root.left = node;
    root.right = expr;
    root.compare = expr.compare;
    root.operation = CQLExpressionOperation.eoOr;
    _lastAnd = root.right!;

    return this;
  }
}
