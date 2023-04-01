import 'package:flutter/foundation.dart';
import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';

class CQLInsertMongoDB extends CQLSection implements ICQLInsert {
  @protected
  late final ICQLNames _columns;
  @protected
  late final ICQLNameValuePairs _values;
  @protected
  late String _tableName;

  CQLInsertMongoDB() : super(name: 'Insert') {
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
  ICQLNames columns() {
    return _columns;
  }

  @override
  T? serialize<T extends Object>() {
    late final String result;

    result = isEmpty()
        ? ''
        : Utils.instance.concat(
            [tableName, '.insertOne({ ', _serializeNameValuePairsForInsert(_values), ' })'],
            delimiter: '');

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

    for (int i = 0; i < pairs.count(); i++) {
      final String field = '${pairs.item(i).name}: ';
      final dynamic value = pairs.item(i).value;

      result = Utils.instance.concat(
          [result, field, _formatValue(value), _checkEnd(i, pairs.count())],
          delimiter: '');
    }

    return result.toLowerCase();
  }

  String _checkEnd(int i, int count) {
    return (i + 1 < count ? ', ' : '');
  }

  String _formatValue(dynamic value) {
    return (value is String) ? '"$value"' : value.toString();
  }
}
