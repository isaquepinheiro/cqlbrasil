import '../interface/cqlbr.interface.dart';
import 'cqlbr.expression.dart';
import 'cqlbr.name.dart';
import 'cqlbr.section.dart';
import 'cqlbr.utils.dart';

class CQLJoin extends CQLSection implements ICQLJoin {
  late final ICQLExpression _condition;
  late final ICQLName _joinTable;
  late final JoinType _joinType;

  CQLJoin() : super(name: 'Join') {
    _condition = CQLExpression();
    _joinTable = CQLName();
    _joinType = JoinType.jtInner;
  }

  @override
  ICQLExpression get condition => _condition;
  @override
  set condition(ICQLExpression value) => _condition = value;

  @override
  JoinType get joinType => _joinType;
  @override
  set joinType(JoinType value) => _joinType = value;

  @override
  ICQLName get joinedTable => _joinTable;
  @override
  set joinedTable(ICQLName value) => _joinTable = value;

  @override
  void clear() {
    _condition.clear();
    _joinTable.clear();
  }

  @override
  bool isEmpty() {
    return _condition.isEmpty() && _joinTable.isEmpty();
  }
}

// JOINS

class CQLJoins implements ICQLJoins {
  late final List<ICQLJoin> _joins;

  CQLJoins() {
    _joins = <ICQLJoin>[];
  }

  @override
  ICQLJoin joins(int idx) {
    return _joins[idx];
  }

  @override
  setJoins(int idx, ICQLJoin value) {
    _joins[idx] = value;
  }

  @override
  void clear() {
    _joins.clear();
  }

  @override
  bool isEmpty() {
    return _joins.isEmpty;
  }

  @override
  ICQLJoin get add {
    _joins.add(CQLJoin());
    return _joins.last;
  }

  @override
  set add(ICQLJoin value) {
    _joins.add(value);
  }

  @override
  int count() {
    return _joins.length;
  }

  @override
  T serialize<T extends Object>() {
    String result = '';

    for (final ICQLJoin join in _joins) {
      result = Utils.instance.concat([
        result,
        _serializeJoinType(join),
        'JOIN',
        join.joinedTable.serialize(),
        'ON',
        join.condition.serialize(),
      ]);
    }

    return result as T;
  }

  String _serializeJoinType(ICQLJoin join) {
    switch (join.joinType) {
      case JoinType.jtInner:
        return 'INNER';
      case JoinType.jtLeft:
        return 'LEFT';
      case JoinType.jtRight:
        return 'RIGHT';
      case JoinType.jtFull:
        return 'FULL';
      // case JoinType.jtCross:
      //   return 'CROSS';
      // case JoinType.jtNatural:
      //   return 'NATURAL';
      // case JoinType.jtLeftOuter:
      //   return 'LEFT OUTER';
      // case JoinType.jtRightOuter:
      //   return 'RIGHT OUTER';
      // case JoinType.jtFullOuter:
      //   return 'FULL OUTER';
      // case JoinType.jtInnerJoin:
      //   return 'INNER JOIN';
      // case JoinType.jtLeftJoin:
      //   return 'LEFT JOIN';
      // case JoinType.jtRightJoin:
      //   return 'RIGHT JOIN';
      // case JoinType.jtFullJoin:
      //   return 'FULL JOIN';
      // case JoinType.jtCrossJoin:
      //   return 'CROSS JOIN';
      // case JoinType.jtNaturalJoin:
      //   return 'NATURAL JOIN';
      // case JoinType.jtLeftOuterJoin:
      //   return 'LEFT OUTER JOIN';
      // case JoinType.jtRightOuterJoin:
      //   return 'RIGHT OUTER JOIN';
      // case JoinType.jtFullOuterJoin:
      //   return 'FULL OUTER JOIN';
      default:
        return '';
    }
  }
}
