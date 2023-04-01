part of 'cqlbr.expression.dart';

extension CQLCriteriaExpressionFunc on CQLCriteriaExpression {
  
  ICQLCriteriaExpression funcExt(ICQLOperator oper) {
    if (oper.value is List<String>) {
      return _funcList(oper);
    } else if (oper.value is String) {
      return _funcString(oper);
    } else {
      return _funcInterface(oper.value);
    }
  }

  ICQLCriteriaExpression _funcList(ICQLOperator oper) {
    final List<String> list = oper.value;
    oper.value = Utils.instance.sqlParamsToStr(list);

    return _orString(oper);
  }

  ICQLCriteriaExpression _funcString(ICQLOperator oper) {
    final ICQLExpression node = CQLExpression();
    node.term = oper.value;
    node.compare = oper.compare;

    return _orInterface(node);
  }

  ICQLCriteriaExpression _funcInterface(ICQLExpression expr) {
    final ICQLExpression node = CQLExpression();
    node.copyWith(_lastAnd);
    _lastAnd.left = node;
    _lastAnd.right = expr;
    _lastAnd.compare = expr.compare;
    _lastAnd.operation = CQLExpressionOperation.eoFunction;

    return this;
  }
}
