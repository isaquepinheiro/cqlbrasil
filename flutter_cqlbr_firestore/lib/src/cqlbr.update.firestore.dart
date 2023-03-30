import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';

class CQLUpdateFirestore extends CQLSection implements ICQLUpdate {
  late final FirebaseFirestore instance;
  @protected
  late final ICQLNameValuePairs _values;
  @protected
  late String _tableName;

  CQLUpdateFirestore(
    this.instance,
  ) : super(name: 'Update') {
    _tableName = '';
    _values = CQLNameValuePairs();
  }

  @override
  String get tableName => _tableName;
  @override
  set tableName(String value) => _tableName = value;

  @override
  void clear() {
    _tableName = '';
    _values.clear();
  }

  @override
  T? serialize<T extends Object>([String? id]) {
    return isEmpty() ? null : instance.collection(_tableName).doc() as T;
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
