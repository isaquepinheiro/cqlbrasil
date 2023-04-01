import '../interface/cqlbr.interface.dart';
import 'cqlbr.utils.dart';

class CQLName implements ICQLName {
  late String _alias;
  late String _name;
  late ICQLCase? _case;

  CQLName() {
    _alias = '';
    _name = '';
    _case = null;
  }

  @override
  String get alias => _alias;
  @override
  set alias(String value) => _alias = value;

  @override
  ICQLCase get cAse => _case!;
  @override
  set case$(ICQLCase value) => _case = value;

  @override
  String get name => _name;
  @override
  set name(String value) => _name = value;

  @override
  void clear() {
    _alias = '';
    _name = '';
  }

  @override
  bool isEmpty() {
    return _alias.isEmpty && _name.isEmpty;
  }

  @override
  T serialize<T extends Object>() {
    String result = _case != null ? '(${_case!.serialize()})' : _name;

    if (_alias.isNotEmpty) {
      result = Utils.instance.concat([result, 'AS', _alias]);
    }

    return result as T;
  }
}

class CQLNames implements ICQLNames {
  late final List<ICQLName> _columns;

  CQLNames() {
    _columns = <ICQLName>[];
  }

  @override
  ICQLName add() {
    _columns.add(CQLName());
    return _columns.last;
  }

  @override
  void setAdd(ICQLName value) {
    _columns.add(value);
  }

  @override
  bool isEmpty() {
    return _columns.isEmpty;
  }

  @override
  void clear() {
    _columns.clear();
  }

  @override
  ICQLName columns(int idx) {
    return _columns[idx];
  }

  @override
  int count() {
    return _columns.length;
  }

  @override
  T serialize<T extends Object>() {
    String result = '';

    for (final ICQLName column in _columns) {
      result = Utils.instance
          .concat([result, _serializeName(column)], delimiter: ', ');
      if (column is ICQLOrderByColumn) {
        result = Utils.instance
            .concat([result, _serializeDirection(column.direction)]);
      }
    }

    return result as T;
  }

  String _serializeName(ICQLName name) {
    return name.serialize();
  }

  String _serializeDirection(OrderByDirection direction) {
    switch (direction) {
      case OrderByDirection.dirAscending:
        return '';
      case OrderByDirection.dirDescending:
        return 'DESC';
      default:
        return '';
    }
  }
}
