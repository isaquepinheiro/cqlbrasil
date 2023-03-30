import 'package:flutter/foundation.dart';

import '../interface/cqlbr.interface.dart';
import 'cqlbr.expression.dart';
import 'cqlbr.injection.dart';
import 'cqlbr.utils.dart';

class CQLCaseWhenThen implements ICQLCaseWhenThen {
  late ICQLExpression _thenExpression;
  late ICQLExpression _whenExpression;

  CQLCaseWhenThen() {
    _thenExpression = CQLExpression();
    _whenExpression = CQLExpression();
  }

  @override
  ICQLExpression get thenExpression => _thenExpression;
  @override
  set thenExpression(ICQLExpression value) => _thenExpression = value;

  @override
  ICQLExpression get whenExpression => _whenExpression;
  @override
  set whenExpression(ICQLExpression value) => _whenExpression = value;
}

// CQLCaseWhenList

class CQLCaseWhenList implements ICQLCaseWhenList {
  late final List<ICQLCaseWhenThen> _whenThenList;

  CQLCaseWhenList() {
    _whenThenList = <ICQLCaseWhenThen>[];
  }

  @override
  ICQLCaseWhenThen add() {
    final whenThen = CQLCaseWhenThen();
    _whenThenList.add(whenThen);
    return _whenThenList.last;
  }

  @override
  int setAdd(ICQLCaseWhenThen whenThen) {
    _whenThenList.add(whenThen);
    return _whenThenList.length;
  }

  @override
  int count() {
    return _whenThenList.length;
  }

  @override
  intsetWhenThen(int idx, ICQLCaseWhenThen value) {
    _whenThenList[idx] = value;
  }

  @override
  ICQLCaseWhenThen whenThen(int idx) {
    return _whenThenList[idx];
  }
}

// CQLCase

class CQLCase implements ICQLCase {
  late final ICQLCaseWhenList _whenList;
  late ICQLExpression _caseExpression;
  late ICQLExpression _elseExpression;

  CQLCase() {
    _caseExpression = CQLExpression();
    _whenList = CQLCaseWhenList();
    _elseExpression = CQLExpression();
  }
  @override
  ICQLExpression get caseExpression => _caseExpression;
  @override
  set caseExpression(ICQLExpression value) => _caseExpression = value;
  @override
  ICQLCaseWhenList get whenList => _whenList;
  @override
  set whenList(ICQLCaseWhenList value) => _whenList = value;
  @override
  ICQLExpression get elseExpression => _elseExpression;
  @override
  set elseExpression(ICQLExpression value) => _elseExpression = value;

  @override
  T serialize<T extends Object>() {
    String result = 'CASE';

    if (!_caseExpression.isEmpty()) {
      result = Utils.instance.concat([result, _caseExpression.serialize()]);
    }
    for (int idx = 0; idx < _whenList.count(); idx++) {
      final ICQLCaseWhenThen whenThen = _whenList.whenThen(idx);
      result = Utils.instance.concat([result, 'WHEN']);

      if (!whenThen.whenExpression.isEmpty()) {
        result = Utils.instance
            .concat([result, whenThen.whenExpression.serialize()]);
      }
      result = Utils.instance
          .concat([result, 'THEN', whenThen.thenExpression.serialize()]);
    }
    if (!_elseExpression.isEmpty()) {
      result =
          Utils.instance.concat([result, 'ELSE', _elseExpression.serialize()]);
    }
    result = Utils.instance.concat([result, 'END']);

    return result as T;
  }

  @protected
  String serializeExpression(ICQLExpression expression) {
    return expression.isEmpty() ? '' : expression.serialize();
  }
}

class CQLCriteriaCase implements ICQLCriteriaCase {
  late final ICQL owner;
  late ICQLCriteriaExpression _lastExpression;
  late ICQLCase _case;

  CQLCriteriaCase({
    required this.owner,
    required String expression,
  }) {
    _case = CQLCase();
    if (expression.isNotEmpty) {
      _case.caseExpression.term = expression;
    }
  }

  @override
  ICQLCase get case$ => _case;

  @override
  ICQLCriteriaCase and$(dynamic expression) {
    _lastExpression.and(expression);

    return this;
  }

  @override
  ICQLCriteriaCase else$(dynamic value) {
    if (value is int) {
      else$(value.toString());
    }
//    _lastExpression = CQLCriteriaExpression(expressionStr: value);
    _lastExpression = injbr.get<ICQLCriteriaExpression>()(expressionStr: value);
    _case.elseExpression = _lastExpression.expression!;

    return this;
  }

  @override
  ICQL end$() {
    return owner;
  }

  @override
  ICQLCriteriaCase or$(dynamic expression) {
    _lastExpression.or(expression);

    return this;
  }

  @override
  ICQLCriteriaCase then$(dynamic value) {
    if (value is int) {
      then$(value.toString());
    }
    assert(_case.whenList.count() > 0, 'CQLCriteriaCase.&Then: Missing When');
//    _lastExpression = CQLCriteriaExpression(expressionStr: value);
    _lastExpression = injbr.get<ICQLCriteriaExpression>()(expressionStr: value);
    _case.whenList.whenThen(_case.whenList.count() - 1).thenExpression =
        _lastExpression.expression!;

    return this;
  }

  @override
  ICQLCriteriaCase when$(dynamic condition) {
    if (condition is List<String>) {
      when$(Utils.instance.sqlParamsToStr(condition));
    } else if (condition is CQLCriteriaExpression) {
      late final ICQLCaseWhenThen whenThen;

      _lastExpression = condition;
      whenThen = _case.whenList.add();
      whenThen.whenExpression = _lastExpression.expression!;
    } else {
      when$(injbr.get<ICQLCriteriaExpression>()(expressionStr: condition));
    }

    return this;
  }
}
