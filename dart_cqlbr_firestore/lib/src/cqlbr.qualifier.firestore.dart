import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';

class CQLSelectQualifiersFirestore extends CQLSelectQualifiers {
  CQLSelectQualifiersFirestore();

  @override
  T? serializePagination<T extends Object>([Query? queryRef]) {
    Query? result = queryRef;

    if (qualifiers.isNotEmpty) {
      for (final ICQLSelectQualifier element in qualifiers) {
        if (element.qualifier == SelectQualifierType.sqPaging) {
          result = result!.limit(element.value);
        }
      }
    }
    return result as T;
  }
}
