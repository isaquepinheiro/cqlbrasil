import 'package:flutter/foundation.dart';

import '../interface/cqlbr.interface.dart';

class CQLSelectQualifier implements ICQLSelectQualifier {
  late final int _value;
  @protected
  late final SelectQualifierType _qualifier;

  @override
  SelectQualifierType get qualifier => _qualifier;
  @override
  set qualifier(SelectQualifierType value) => _qualifier = value;

  @override
  int get value => _value;
  @override
  set value(int value) => _value = value;
}

class CQLSelectQualifiers implements ICQLSelectQualifiers {
  late final List<ICQLSelectQualifier> _qualifiers;
  late bool _executingPagination;
  CQLSelectQualifiers() {
    _executingPagination = false;
    _qualifiers = <ICQLSelectQualifier>[];
  }

  @override
  ICQLSelectQualifier add() {
    final qualifier = CQLSelectQualifier();
    return qualifier;
  }

  List<ICQLSelectQualifier> get qualifiers => _qualifiers;

  @override
  setAdd(ICQLSelectQualifier value) {
    final List<SelectQualifierType> types = <SelectQualifierType>[
      SelectQualifierType.sqFirst,
      SelectQualifierType.sqSkip
    ];
    _qualifiers.add(value);
    if (types.contains(value.qualifier)) {
      _executingPagination = true;
    }
  }

  @override
  void clear() {
    _qualifiers.clear();
  }

  @override
  int count() {
    return _qualifiers.length;
  }

  @override
  bool executingPagination() {
    return _executingPagination;
  }

  @override
  bool isEmpty() {
    return count() == 0;
  }

  @override
  ICQLSelectQualifier qualifier(int idx) {
    return _qualifiers[idx];
  }

  @override
  String serializeDistinct() {
    return _qualifiers
            .where((element) =>
                element.qualifier == SelectQualifierType.sqDistinct)
            .isEmpty
        ? ''
        : 'DISTINCT';
  }

  @override
  String serializePagination() {
    throw Exception('Not implemented');
  }
}
