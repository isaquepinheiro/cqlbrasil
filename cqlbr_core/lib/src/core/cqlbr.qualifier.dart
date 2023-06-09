import 'package:meta/meta.dart';

import '../interface/cqlbr.interface.dart';

class CQLSelectQualifier implements ICQLSelectQualifier {
  late final dynamic _value;
  @protected
  late final SelectQualifierType _qualifier;

  @override
  SelectQualifierType get qualifier => _qualifier;
  @override
  set qualifier(SelectQualifierType value) => _qualifier = value;

  @override
  dynamic get value => _value;
  @override
  set value(dynamic value) => _value = value;
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
      // SelectQualifierType.sqFirst,
      SelectQualifierType.sqSkip,
      SelectQualifierType.sqPaging
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
  T? serializePagination<T extends Object>() {
    throw Exception('Not implemented');
  }
}
