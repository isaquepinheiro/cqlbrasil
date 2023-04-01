import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';

class CQLOrderByFirestore extends CQLSection implements ICQLOrderBy {
  late final CQLNames _columns;

  CQLOrderByFirestore() : super(name: 'OrderBy') {
    _columns = CQLOrderByColumns();
  }

  @override
  ICQLNames columns() {
    return _columns;
  }

  @override
  T? serialize<T extends Object>([Query? queryRef]) {
    String serialize = '';
    OrderByDirection orderByDirection = OrderByDirection.dirNone;
    Query? result = queryRef;

    if (isEmpty()) {
      return null;
    }
    for (var iFor = 0; iFor < _columns.count(); iFor++) {
      final ICQLName column = _columns.columns(iFor);
      serialize = Utils.instance
          .concat([serialize, _serializeName(column)], delimiter: ', ');
      if (column is ICQLOrderByColumn) {
        orderByDirection = column.direction;
      }
    }
    if (orderByDirection == OrderByDirection.dirNone) {
      result!.orderBy(serialize);
    } else {
      result!.orderBy(serialize,
          descending: (orderByDirection == OrderByDirection.dirDescending
              ? true
              : false));
    }
    return result as T;
  }

  String _serializeName(ICQLName name) {
    return name.serialize();
  }

  @override
  void clear() {
    _columns.clear();
  }

  @override
  bool isEmpty() {
    return _columns.isEmpty();
  }
}
