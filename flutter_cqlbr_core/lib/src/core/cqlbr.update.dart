import 'package:flutter/foundation.dart';

import '../interface/cqlbr.interface.dart';
import 'cqlbr.namevalue.dart';
import 'cqlbr.section.dart';
import 'cqlbr.utils.dart';

class CQLUpdate extends CQLSection implements ICQLUpdate {
  @protected
  late String _tableName;
  @protected
  late final ICQLNameValuePairs _values;

  CQLUpdate() : super(name: 'Update') {
    _tableName = '';
    _values = CQLNameValuePairs();
  }

  @override
  String get tableName => _tableName;
  @override
  set tableName(String value) => _tableName = value;

  @override
  T? serialize<T extends Object>() {
    return isEmpty()
        ? '' as T
        : Utils.instance.concat([
            'UPDATE',
            _tableName,
            'SET',
            _serializeNameValuePairsForUpdate(_values),
          ]) as T;
  }

  @override
  ICQLNameValuePairs values() {
    return _values;
  }

  @override
  bool isEmpty() {
    return _tableName.isEmpty;
  }

  @override
  void clear() {
    _tableName = '';
    _values.clear();
  }

  @protected
  String _serializeNameValuePairsForUpdate(ICQLNameValuePairs pairs) {
    String result = '';

    for (int i = 0; i < pairs.count(); i++) {
      result = Utils.instance.concat(
        [
          result,
          Utils.instance.concat([pairs.item(i).name, '=', pairs.item(i).value])
        ],
        delimiter: ', ',
      );
    }

    return result;
  }
}
