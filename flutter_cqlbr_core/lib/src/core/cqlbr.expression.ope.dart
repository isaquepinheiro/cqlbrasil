part of 'cqlbr.expression.dart';

extension CQLCriteriaExpressionOpe on CQLCriteriaExpression {
  ICQLCriteriaExpression opeExt(ICQLOperator oper) {
    if (oper.value is List<String>) {
      return _opeList(oper);
    } else if (oper.value is String) {
      return _opeString(oper);
    } else {
      return _opeInterface(oper.value);
    }
  }

  ICQLCriteriaExpression _opeList(ICQLOperator oper) {
    final List<String> list = oper.value;
    oper.value = Utils.instance.sqlParamsToStr(list);

    return _opeString(oper);
  }

  ICQLCriteriaExpression _opeString(ICQLOperator oper) {
    final ICQLExpression node = CQLExpression();
    node.term = oper.value;
    node.compare = oper.compare;

    return _opeInterface(node);
  }

  ICQLCriteriaExpression _opeInterface(ICQLExpression expr) {
    final ICQLExpression node = CQLExpression();

    node.copyWith(_lastAnd);
    _lastAnd.left = node;
    _lastAnd.right = expr;
    _lastAnd.compare = expr.compare;
    _lastAnd.operation = CQLExpressionOperation.eoOperation;

    return this;
  }
}
