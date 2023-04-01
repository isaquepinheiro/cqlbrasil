import '../interface/cqlbr.interface.dart';
import 'cqlbr.name.dart';
import 'cqlbr.section.dart';
import 'cqlbr.utils.dart';

class CQLOrderByColumn extends CQLName implements ICQLOrderByColumn {
  late OrderByDirection _direction;

  CQLOrderByColumn() {
    _direction = OrderByDirection.dirAscending;
  }

  @override
  OrderByDirection get direction => _direction;
  @override
  set direction(OrderByDirection value) => _direction = value;
}

class CQLOrderByColumns extends CQLNames {
  @override
  ICQLName add() {
    final CQLOrderByColumn result = CQLOrderByColumn();
    setAdd(result);

    return result;
  }
}

class CQLOrderBy extends CQLSection implements ICQLOrderBy {
  late final CQLNames _columns;

  CQLOrderBy() : super(name: 'OrderBy') {
    _columns = CQLOrderByColumns();
  }

  @override
  ICQLNames columns() {
    return _columns;
  }

  @override
  T? serialize<T extends Object>() {
    return isEmpty()
        ? '' as T
        : Utils.instance.concat(['ORDER BY', _columns.serialize()]) as T;
  }

  @override
  void clear() {
    _columns.clear();
  }

  @override
  bool isEmpty() {
    return _columns.isEmpty();
  }
}
