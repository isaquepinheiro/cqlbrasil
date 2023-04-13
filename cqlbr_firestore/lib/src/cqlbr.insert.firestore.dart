import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cqlbr_core/cqlbr_core.dart';
import 'package:flutter/foundation.dart';

class CQLInsertFirestore extends CQLSection implements ICQLInsert {
  late final FirebaseFirestore instance;
  @protected
  late final ICQLNames _columns;
  @protected
  late final ICQLNameValuePairs _values;
  @protected
  late String _tableName;

  CQLInsertFirestore(
    this.instance,
  ) : super(name: 'Insert') {
    _tableName = '';
    _columns = CQLNames();
    _values = CQLNameValuePairs();
  }

  @override
  String get tableName => _tableName;
  @override
  set tableName(String value) => _tableName = value;

  @override
  void clear() {
    _tableName = '';
    _columns.clear();
    _values.clear();
  }

  @override
  ICQLNames columns() => _columns;

  @override
  T? serialize<T extends Object>([String? id]) {
    return isEmpty() ? null : instance.collection(_tableName) as T;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> result = {};
    if (_values.count() == 0) {
      return {};
    }
    for (int i = 0; i < _values.count(); i++) {
      result.addAll({_values.item(i).name: _values.item(i).value});
    }

    return result;
  }

  @override
  ICQLNameValuePairs values() {
    return _values;
  }

  @override
  bool isEmpty() {
    return _tableName.isEmpty;
  }
}
