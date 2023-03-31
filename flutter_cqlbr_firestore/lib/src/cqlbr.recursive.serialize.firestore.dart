import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';

class CQLRecursiveSerializeFirestore {
  static Query? serialize<T extends Object>(
      ICQLExpression expression, Query? queryRef) {
    Query? result = queryRef;

    if (expression.isEmpty()) {
      return null;
    }
    switch (expression.operation) {
      case CQLExpressionOperation.eoNone:
        {
          result = _serializeWhere<T>(expression, result);
          return result;
        }
      case CQLExpressionOperation.eoAnd:
        {
          result = serialize(expression.left!, result);
          result = serialize(expression.right!, result);
          return result;
        }
      case CQLExpressionOperation.eoOr:
        {
          result = serialize(expression.left!, result);
          result = serialize(expression.right!, result);
          return result;
        }
      case CQLExpressionOperation.eoOperation:
        {
          result = _serializeWhere<Query>(expression, result);
          return result;
        }
      // case CQLExpressionOperation.eoFunction:
      //   return _serializeWhere() as T;
      default:
        throw Exception(
            'CQLExpression.Serialize: Unknown expression operation: ${expression.operation}');
    }
  }

  static Query? _serializeWhere<T extends Object>(
      ICQLExpression expression, Query? queryRef) {
    switch (expression.compare) {
      case CQLOperatorCompare.fcEqual:
        return queryRef?.where(expression.left!.serialize<String>()!,
            isEqualTo: expression.right?.serialize<String>());
      case CQLOperatorCompare.fcNotEqual:
        return queryRef?.where(expression.left!.serialize<String>()!,
            isNotEqualTo: expression.right?.serialize<String>());
      case CQLOperatorCompare.fcLess:
        return queryRef?.where(expression.left!.serialize<String>()!,
            isLessThan: expression.right?.serialize<String>());
      case CQLOperatorCompare.fcLessEqual:
        return queryRef?.where(expression.left!.serialize<String>()!,
            isLessThanOrEqualTo: expression.right?.serialize<String>());
      case CQLOperatorCompare.fcGreater:
        return queryRef?.where(expression.left!.serialize<String>()!,
            isGreaterThan: expression.right?.serialize<String>());
      case CQLOperatorCompare.fcGreaterEqual:
        return queryRef?.where(expression.left!.serialize<String>()!,
            isGreaterThanOrEqualTo: expression.right?.serialize<String>());
      case CQLOperatorCompare.fcLike:
        return queryRef?.where(expression.left!.serialize<String>()!,
            arrayContains: expression.right?.serialize<String>());
      default:
        return _serializeWhere<Query>(expression.right!, queryRef);
    }
  }
}
