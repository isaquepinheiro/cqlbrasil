import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';
import 'cqlbr.recursive.serialize.firestore.dart';

class CQLWhereFirestore extends CQLSection implements ICQLWhere {
  late final ICQLExpression _expression;

  CQLWhereFirestore() : super(name: 'Where') {
    _expression = CQLExpression();
  }

  @override
  ICQLExpression get expression => _expression;
  @override
  set expression(ICQLExpression value) => _expression = value;

  @override
  T? serialize<T extends Object>([Query? queryRef]) {
    return isEmpty()
        ? null
        : CQLRecursiveSerializeFirestore.serialize<Query>(_expression, queryRef)
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
