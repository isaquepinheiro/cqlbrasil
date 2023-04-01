import 'package:flutter/foundation.dart';

import '../interface/cqlbr.interface.dart';
import 'cqlbr.name.dart';
import 'cqlbr.section.dart';
import 'cqlbr.utils.dart';

class CQLDelete extends CQLSection implements ICQLDelete {
  @protected
  late final ICQLNames _tableNames;

  CQLDelete() : super(name: 'Delete') {
    _tableNames = CQLNames();
  }

  @override
  T? serialize<T extends Object>() {
    return isEmpty()
        ? '' as T
        : Utils.instance.concat([
            'DELETE FROM',
            _tableNames.serialize(),
          ]) as T;
  }

  @override
  bool isEmpty() => _tableNames.isEmpty();

  @override
  void clear() {
    _tableNames.clear();
  }

  @override
  ICQLNames get tableNames => _tableNames;
}
