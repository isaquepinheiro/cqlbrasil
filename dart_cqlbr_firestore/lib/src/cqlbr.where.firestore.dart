import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';
import 'cqlbr.expression.serialize.firestore.dart';

class CQLWhereFirestore extends CQLSection implements ICQLWhere {
  late final ICQLExpression _expression;
  late final CQLExpressionSerializeFirestore _serialize;

  CQLWhereFirestore() : super(name: 'Where') {
    _expression = CQLExpression();
    _serialize = CQLExpressionSerializeFirestore();
  }

  @override
  ICQLExpression get expression => _expression;
  @override
  set expression(ICQLExpression value) => _expression = value;

  @override
  T? serialize<T extends Object>([Query? queryRef]) {
    return isEmpty()
        ? null
        : _serialize.serialize<Query>(_expression, queryRef)
            as T;
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
