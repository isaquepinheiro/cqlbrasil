import 'package:flutter/foundation.dart';

import '../interface/cqlbr.interface.dart';
import 'cqlbr.name.dart';
import 'cqlbr.namevalue.dart';
import 'cqlbr.section.dart';
import 'cqlbr.utils.dart';

class CQLInsert extends CQLSection implements ICQLInsert {
  @protected
  late final ICQLNames _columns;
  @protected
  late final ICQLNameValuePairs _values;
  @protected
  late String _tableName;

  CQLInsert() : super(name: 'Insert') {
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
  T? serialize<T extends Object>() {
    String result = '';

    if (!isEmpty()) {
      result = Utils.instance.concat(['INSERT INTO ', _tableName]);
      if (_columns.count() > 0) {
        result =
            Utils.instance.concat([result, ' (', _columns.serialize<T>(), ')']);
      } else {
        result = Utils.instance
            .concat([result, _serializeNameValuePairsForInsert(_values)]);
      }
    } else {
      result = '';
    }

    return result as T;
  }

  @override
  ICQLNameValuePairs values() {
    return _values;
  }

  @override
  bool isEmpty() {
    return _tableName.isEmpty;
  }

  @protected
  String _serializeNameValuePairsForInsert(ICQLNameValuePairs pairs) {
    String result = '';
    if (pairs.count() == 0) {
      return result;
    }
    String values = '';
    String columns = '';

    for (int i = 0; i < pairs.count(); i++) {
      columns = Utils.instance.concat([columns, pairs.item(i).name, ', ']);
      values = Utils.instance.concat([values, pairs.item(i).value, ', ']);
    }
    result = Utils.instance
        .concat(['(', columns, ') VALUES (', values, ')'], delimiter: '');

    return result;
  }
}
