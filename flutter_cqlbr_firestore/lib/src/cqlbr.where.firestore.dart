import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';

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
  T? serialize<T extends Object>([CollectionReference? collectionRef]) {
    switch (_expression.compare) {
      case CQLOperatorCompare.fcEqual:
        return collectionRef?.where(_expression.left!.serialize<String>(),
            isEqualTo: _expression.right?.serialize<String>()) as T;
      case CQLOperatorCompare.fcNotEqual:
        return collectionRef?.where(_expression.left!.serialize<String>(),
            isNotEqualTo: _expression.right?.serialize<String>()) as T;
      case CQLOperatorCompare.fcLess:
        return collectionRef?.where(_expression.left!.serialize<String>(),
            isLessThan: _expression.right?.serialize<String>()) as T;
      case CQLOperatorCompare.fcLessEqual:
        return collectionRef?.where(_expression.left!.serialize<String>(),
            isLessThanOrEqualTo: _expression.right?.serialize<String>()) as T;
      case CQLOperatorCompare.fcGreater:
        return collectionRef?.where(_expression.left!.serialize<String>(),
            isGreaterThan: _expression.right?.serialize<String>()) as T;
      case CQLOperatorCompare.fcGreaterEqual:
        return collectionRef?.where(_expression.left!.serialize<String>(),
                isGreaterThanOrEqualTo: _expression.right?.serialize<String>())
            as T;
      case CQLOperatorCompare.fcLike:
        return collectionRef?.where(_expression.left!.serialize<String>(),
            arrayContains: _expression.right?.serialize<String>()) as T;
      default:
        return collectionRef as T;
    }
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
