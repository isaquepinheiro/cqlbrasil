part of 'cqlbr.expression.dart';

extension CQLCriteriaExpressionAnd on CQLCriteriaExpression {
  ICQLCriteriaExpression andExt(ICQLOperator oper) {
    if (oper.value is List<String>) {
      return _andList(oper);
    } else if (oper.value is String) {
      return _andString(oper);
    } else {
      return _andInterface(oper.value);
    }
  }

  ICQLCriteriaExpression _andList(ICQLOperator oper) {
    final List<String> list = oper.value;
    oper.value = Utils.instance.sqlParamsToStr(list);

    return _andString(oper);
  }

  ICQLCriteriaExpression _andString(ICQLOperator oper) {
    final ICQLExpression node = CQLExpression();
    node.term = oper.value;
    node.compare = oper.compare;

    return _andInterface(node);
  }

  ICQLCriteriaExpression _andInterface(ICQLExpression expr) {
    final ICQLExpression root = _expression!;

    if (root.isEmpty()) {
      root.copyWith(expr);
      _lastAnd = root;
    } else {
      final ICQLExpression node = CQLExpression();

      node.copyWith(root);
      root.left = node;
      root.right = expr;
      root.compare = expr.compare;
      root.operation = CQLExpressionOperation.eoAnd;
      _lastAnd = root.right!;
    }

    return this;
  }
}
