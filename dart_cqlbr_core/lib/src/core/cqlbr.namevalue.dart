import '../interface/cqlbr.interface.dart';

class CQLNameValue implements ICQLNameValue {
  late String _name;
  late dynamic _value;

  @override
  String get name => _name;
  @override
  set name(String value) => _name = value;

  @override
  dynamic get value => _value;
  @override
  set value(dynamic value) => _value = value;

  @override
  void clear() {
    _name = '';
    _value = '';
  }

  @override
  bool isEmpty() {
    return _name.isEmpty && _value.isEmpty;
  }
}

class CQLNameValuePairs implements ICQLNameValuePairs {
  late final List<ICQLNameValue> _values;

  CQLNameValuePairs() {
    _values = <ICQLNameValue>[];
  }

  @override
  void clear() {
    _values.clear();
  }

  @override
  bool isEmpty() {
    return _values.isEmpty;
  }

  @override
  ICQLNameValue add() {
    final ICQLNameValue value = CQLNameValue();
    _values.add(value);
    return value;
  }

  @override
  setAdd(ICQLNameValue value) {
    _values.add(value);
  }

  @override
  int count() {
    return _values.length;
  }

  @override
  ICQLNameValue item(int idx) {
    return _values[idx];
  }
}
