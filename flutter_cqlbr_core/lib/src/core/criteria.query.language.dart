import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';

enum Section {
  secSelect,
  secDelete,
  secInsert,
  secUpdate,
  secJoin,
  secWhere,
  secGroupBy,
  secHaving,
  secOrderBy;
}

typedef Fun = CQLFunctions;

class CQLBr implements ICQL {
  late final ICQLSelect _select;
  late final ICQLOperators _operators;
  late final ICQLFunctions _functions;
  late final ICQLAST _ast;
  late Section _activeSection;
  late Operator _activeOperator;
  late ICQLCriteriaExpression? _activeExpression;
  late ICQLNameValuePairs? _activeValues;

  CQLBr({
    required ICQLSelect select,
  }) {
    _select = select;
    _activeOperator = Operator.opeNone;
    _ast = CQLAST(database: _select.driver);
    _ast.clear();
//    _operators = CQLBrRegister.instance.cqlOperators[_select.driver]!;
    _operators = CQLOperators(database: _select.driver);
    _functions = CQLFunctions(database: _select.driver);
    _activeExpression = null;
    _activeValues = null;

    // Caso não seja informado o cirteria por outro, o padrão será esse
    if (!injbr.containsKey<ICQLCriteriaExpression>()) {
      injbr.register<ICQLCriteriaExpression>((i) => CQLCriteriaExpression());
    }
  }

  ICQLSelect get select => _select;
  ICQLAST get ast => _ast;

  @override
  ICQL as$(String alias) {
    _assertSection([Section.secSelect, Section.secDelete, Section.secJoin]);
    _assertHaveName();
    _ast.astName!.alias = alias;

    return this;
  }

  @override
  ICQL all$() {
    if (_select.driver == CQLDatabase.dbnMongoDB ||
        _select.driver == CQLDatabase.dbnFirestore) {
      return this;
    }

    return column$('*');
  }

  @override
  ICQL and$(dynamic expression) {
    _activeOperator = Operator.opeAnd;
    _activeExpression!.and(CQLOperator(value: expression));

    return this;
  }

  @override
  ICQLFunctions asFun$() {
    return _functions;
  }

  @override
  T asResult<T extends Object>() {
    _activeOperator = Operator.opeNone;

    return CQLBrRegister.instance.serialize(_select.driver).asResult<T>(_ast);
  }

  @override
  ICQLCriteriaCase case$(dynamic expression) {
    if (expression is List<String>) {
      case$(Utils.instance.sqlParamsToStr(expression));
    } else if (expression is ICQLCriteriaExpression) {
      final result = CQLCriteriaCase(
        owner: this,
        expression: '',
      );

      return result.and$(expression);
    }

    String expr = expression ?? '';
    late ICQLCriteriaCase result;

    if (expr.isEmpty) {
      expr = _ast.astName!.name;
    }
    result = CQLCriteriaCase(
      owner: this,
      expression: expr,
    );
    _ast.astName!.case$ = result.case$;

    return result;
  }

  @override
  ICQL clear$() {
    _ast.astSection!.clear();

    return this;
  }

  @override
  ICQL clearAll$() {
    _ast.clear();

    return this;
  }

  @override
  ICQL column$([dynamic columnName = '', String tableName = '']) {
    if (columnName is List<String>) {
      column$(Utils.instance.sqlParamsToStr(columnName));
    } else if (columnName is ICQLCriteriaCase) {
      _ast.astName = _ast.astColumns!.add();
      _ast.astName!.case$ = columnName.case$;
    } else {
      _ast.astName = _ast.astColumns!.add();
      _ast.astName!.name =
          tableName.isEmpty ? columnName : '$tableName.$columnName';
    }

    return this;
  }

  @override
  ICQL concat$(List<String> value) {
    _assertSection([Section.secSelect, Section.secJoin, Section.secWhere]);
    _assertHaveName();
    switch (_activeSection) {
      case Section.secSelect:
        _ast.astName!.name = _functions.concat(value);
        break;
      case Section.secWhere:
        _activeExpression!.func(_functions.concat(value));
        break;
      default:
    }

    return this;
  }

  @override
  ICQL count$() {
    _assertSection([Section.secSelect, Section.secJoin, Section.secDelete]);
    _assertHaveName();
    _ast.astName!.name = _functions.count(_ast.astName!.name);

    return this;
  }

  @override
  ICQL date$(String value) {
    _assertSection([Section.secSelect, Section.secJoin, Section.secWhere]);
    _assertHaveName();
    switch (_activeSection) {
      case Section.secSelect:
        _ast.astName!.name = _functions.date(value);
        break;
      case Section.secWhere:
        _activeExpression!.func(_functions.date(value));
        break;
      default:
    }

    return this;
  }

  @override
  ICQL day$(String value) {
    _assertSection([Section.secSelect, Section.secJoin, Section.secWhere]);
    _assertHaveName();
    switch (_activeSection) {
      case Section.secSelect:
        _ast.astName!.name = _functions.day(value);
        break;
      case Section.secWhere:
        _activeExpression!.func(_functions.day(value));
        break;
      default:
    }

    return this;
  }

  @override
  ICQL delete$() {
    _setSection(Section.secDelete);

    return this;
  }

  @override
  ICQL desc$() {
    _assertSection([Section.secOrderBy]);
    assert(
        _ast.astColumns!.count() > 0, 'Criteria.Desc: No columns set up yet');
    (_ast.orderBy().columns().columns(_ast.orderBy().columns().count() - 1)
            as ICQLOrderByColumn)
        .direction = OrderByDirection.dirDescending;

    return this;
  }

  @override
  ICQL distinct$() {
    _assertSection([Section.secSelect]);

    final ICQLSelectQualifier qualifier = _ast.select().qualifiers.add();
    qualifier.qualifier = SelectQualifierType.sqDistinct;
    _ast.select().qualifiers.setAdd(qualifier);

    return this;
  }

  @override
  ICQL equal$([dynamic value = '']) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    if (value is String && value.isEmpty) {
      _activeExpression!.func(_operators.isEqual(value));
    } else {
      _activeExpression!.ope(_operators.isEqual(value));
    }

    return this;
  }

  @override
  ICQL exists$(String value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isExists(value));

    return this;
  }

  @override
  ICQLCriteriaExpression expression$(dynamic term) {
    if (term is List<String>) {
      expression$(Utils.instance.sqlParamsToStr(term));
    }

//    return CQLCriteriaExpression(expressionStr: term);
    return injbr.get<ICQLCriteriaExpression>()(expressionStr: term);
  }

  @override
  ICQL first$(int value) {
    _assertSection([Section.secSelect, Section.secWhere, Section.secOrderBy]);
    final ICQLSelectQualifier qualifier = _ast.select().qualifiers.add();
    qualifier.qualifier = SelectQualifierType.sqFirst;
    qualifier.value = value;
    _ast.select().qualifiers.setAdd(qualifier);

    return this;
  }

  @override
  ICQL from$(dynamic tableName, [String alias = '']) {
    if (tableName is ICQLCriteriaExpression) {
      final ICQLCriteriaExpression fromType = tableName;
      from$('(${fromType.asResult<String>()})');
    } else if (tableName is ICQL) {
      final ICQL fromType = tableName;
      from$('(${fromType.asResult()})');
    }
    _assertSection([Section.secSelect, Section.secDelete]);
    _ast.astName = _ast.astTableNames!.add();
    _ast.astName!.name = tableName;
    _ast.astName!.alias = alias;

    return this;
  }

  @override
  ICQL fullJoin$(String tableName, [String alias = '']) {
    alias.isEmpty
        ? _createJoin(JoinType.jtFull, tableName)
        : _createJoin(JoinType.jtFull, tableName).as$(alias);

    return this;
  }

  @override
  ICQL greaterEqThan$(dynamic value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isGreaterEqThan(value));

    return this;
  }

  @override
  ICQL greaterThan$(dynamic value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isGreaterThan(value));

    return this;
  }

  @override
  ICQL groupBy$(dynamic columnName) {
    _setSection(Section.secGroupBy);

    return columnName.isEmpty$ ? this : column$(columnName);
  }

  @override
  ICQL having$(dynamic expression) {
    if (expression is List<String>) {
      having$(Utils.instance.sqlParamsToStr(expression));
    } else if (expression is ICQLCriteriaExpression) {
      _setSection(Section.secHaving);

      return and$(expression);
    }

    _setSection(Section.secHaving);

    return expression.isEmpty$ ? this : and$(expression);
  }

  @override
  ICQL in$(dynamic value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isIn(value));

    return this;
  }

  @override
  ICQL innerJoin$(String tableName, [String alias = '']) {
    alias.isEmpty
        ? _createJoin(JoinType.jtInner, tableName)
        : _createJoin(JoinType.jtInner, tableName).as$(alias);

    return this;
  }

  @override
  ICQL insert$() {
    _setSection(Section.secInsert);

    return this;
  }

  @override
  ICQL into$(String tableName) {
    _assertSection([Section.secInsert]);
    _ast.insert().tableName = tableName;

    return this;
  }

  @override
  bool isEmpty$() {
    return _ast.astSection!.isEmpty();
  }

  @override
  ICQL isNotNull$() {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isNotNull());

    return this;
  }

  @override
  ICQL isNull$() {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isNull());

    return this;
  }

  @override
  ICQL leftJoin$(String tableName, [String alias = '']) {
    alias.isEmpty
        ? _createJoin(JoinType.jtLeft, tableName)
        : _createJoin(JoinType.jtLeft, tableName).as$(alias);

    return this;
  }

  @override
  ICQL lessEqThan$(dynamic value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isLessEqThan(value));

    return this;
  }

  @override
  ICQL lessThan$(dynamic value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isLessThan(value));

    return this;
  }

  @override
  ICQL like$(String value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isLike(value));

    return this;
  }

  @override
  ICQL likeLeft$(String value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isLikeLeft(value));

    return this;
  }

  @override
  ICQL likeRight$(String value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isLikeRight(value));

    return this;
  }

  @override
  ICQL limit$(int value) {
    return first$(value);
  }

  @override
  ICQL lower$() {
    _assertSection([Section.secSelect, Section.secDelete, Section.secJoin]);
    _assertHaveName();
    _ast.astName!.name = _functions.lower(_ast.astName!.name);

    return this;
  }

  @override
  ICQL max$() {
    _assertSection([Section.secSelect, Section.secDelete, Section.secJoin]);
    _assertHaveName();
    _ast.astName!.name = _functions.max(_ast.astName!.name);

    return this;
  }

  @override
  ICQL min$() {
    _assertSection([Section.secSelect, Section.secDelete, Section.secJoin]);
    _assertHaveName();
    _ast.astName!.name = _functions.min(_ast.astName!.name);

    return this;
  }

  @override
  ICQL month$(String value) {
    _assertSection([Section.secSelect, Section.secJoin, Section.secWhere]);
    _assertHaveName();
    switch (_activeSection) {
      case Section.secSelect:
        _ast.astName!.name = _functions.month(value);
        break;
      case Section.secWhere:
        _activeExpression!.func(_functions.month(value));
        break;
      default:
    }

    return this;
  }

  @override
  ICQL notEqual$(dynamic value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isNotEqual(value));

    return this;
  }

  @override
  ICQL notExists$(String value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isNotExists(value));

    return this;
  }

  @override
  ICQL notIn$(dynamic value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isNotIn(value));

    return this;
  }

  @override
  ICQL notLike$(String value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isNotLike(value));

    return this;
  }

  @override
  ICQL notLikeFull$(String value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isNotLikeFull(value));

    return this;
  }

  @override
  ICQL notLikeLeft$(String value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isNotLikeLeft(value));

    return this;
  }

  @override
  ICQL notLikeRight$(String value) {
    _assertOperator([Operator.opeWhere, Operator.opeAnd, Operator.opeOr]);
    _activeExpression!.ope(_operators.isNotLikeRight(value));

    return this;
  }

  @override
  ICQL offset$(int value) {
    return skip$(value);
  }

  @override
  ICQL on$(dynamic expression) {
    if (expression is List<String>) {
      on$(Utils.instance.sqlParamsToStr(expression));
    }

    return and$(expression);
  }

  @override
  ICQL or$(dynamic expression) {
    _activeOperator = Operator.opeOr;
    _activeExpression!.or(CQLOperator(value: expression));

    return this;
  }

  @override
  ICQL orderBy$(dynamic columnName) {
    _setSection(Section.secOrderBy);

    return columnName.isEmpty ? this : column$(columnName);
  }

  @override
  ICQL rightJoin$(String tableName, [String alias = '']) {
    alias.isEmpty
        ? _createJoin(JoinType.jtRight, tableName)
        : _createJoin(JoinType.jtRight, tableName).as$(alias);

    return this;
  }

  @override
  ICQL select$([dynamic columnName = '']) {
    _setSection(Section.secSelect);

    return columnName.isEmpty ? this : column$(columnName);
  }

  @override
  ICQL set$(String columnName, dynamic columnValue) {
    if (columnValue is List<String>) {
      return _internalSet(
          columnName, Utils.instance.sqlParamsToStr(columnValue));
    } else if (columnValue is DateTime) {
      return _internalSet(columnName,
          '\'${Utils.instance.dateTimeToSQLFormat(_select.driver, columnValue)}\'');
    }

    return _internalSet(columnName, columnValue);
  }

  @override
  ICQL skip$(int value) {
    _assertSection([Section.secSelect, Section.secWhere, Section.secOrderBy]);
    final ICQLSelectQualifier qualifier = _ast.select().qualifiers.add();
    qualifier.qualifier = SelectQualifierType.sqSkip;
    qualifier.value = value;
    _ast.select().qualifiers.setAdd(qualifier);

    return this;
  }

  @override
  ICQL substring$(int start, int length) {
    _assertSection([Section.secSelect, Section.secDelete, Section.secJoin]);
    _assertHaveName();
    _ast.astName!.name =
        _functions.substring(_ast.astName!.name, start, length);

    return this;
  }

  @override
  ICQL update$(String tableName) {
    _setSection(Section.secUpdate);
    _ast.update().tableName = tableName;

    return this;
  }

  @override
  ICQL upper$() {
    _assertSection([Section.secSelect, Section.secDelete, Section.secJoin]);
    _assertHaveName();
    _ast.astName!.name = _functions.upper(_ast.astName!.name);

    return this;
  }

  @override
  ICQL values$(String columnName, dynamic columnValue) {
    if (columnValue is List<String>) {
      return _internalSet(
          columnName, Utils.instance.sqlParamsToStr(columnValue));
    }

    return _internalSet(columnName, columnValue);
  }

  @override
  ICQL where$([dynamic expression = '']) {
    if (expression is List<String>) {
      return where$(Utils.instance.sqlParamsToStr(expression));
    }
    _setSection(Section.secWhere);
    _activeOperator = Operator.opeWhere;
    if (expression is String) {
      return (expression.isEmpty) ? this : and$(expression);
    } else {
      return and$(expression!);
    }
  }

  @override
  ICQL year$(String value) {
    _assertSection([Section.secSelect, Section.secJoin, Section.secWhere]);
    _assertHaveName();
    switch (_activeSection) {
      case Section.secSelect:
        _ast.astName!.name = _functions.year(value);
        break;
      case Section.secWhere:
        _activeExpression!.func(_functions.year(value));
        break;
      default:
    }

    return this;
  }

  void _assertSection(List<Section> sections) {
    if (!sections.contains(_activeSection)) {
      throw ArgumentError('CQL: Not supported in this section');
    }
  }

  void _assertOperator(List<Operator> operators) {
    if (!operators.contains(_activeOperator)) {
      throw ArgumentError('CQL: Not supported in this operator');
    }
  }

  void _assertHaveName() {
    if (_ast.astName == null) {
      throw ArgumentError('Criteria: Current name is not set');
    }
  }

  ICQL _internalSet(String columnName, dynamic columnValue) {
    _assertSection([Section.secInsert, Section.secUpdate]);
    final ICQLNameValue pair = _activeValues!.add();
    pair.name = columnName;
    pair.value = columnValue;

    return this;
  }

  void _setSection(Section section) {
    switch (section) {
      case Section.secSelect:
        _defineSectionSelect();
        break;
      case Section.secDelete:
        _defineSectionDelete();
        break;
      case Section.secInsert:
        _defineSectionInsert();
        break;
      case Section.secUpdate:
        _defineSectionUpdate();
        break;
      case Section.secWhere:
        _defineSectionWhere();
        break;
      case Section.secGroupBy:
        _defineSectionGroupBy();
        break;
      case Section.secHaving:
        _defineSectionHaving();
        break;
      case Section.secOrderBy:
        _defineSectionOrderBy();
        break;
      default:
    }

    _activeSection = section;
  }

  void _defineSectionSelect() {
    clearAll$();
    _ast.astSection = _ast.select();
    _ast.astColumns = _ast.select().columns;
    _ast.astTableNames = _ast.select().tableNames;
    _activeExpression = null;
    _activeValues = null;
  }

  void _defineSectionDelete() {
    clearAll$();
    _ast.astSection = _ast.delete();
    _ast.astColumns = null;
    _ast.astTableNames = _ast.delete().tableNames;
    _activeExpression = null;
    _activeValues = null;
  }

  void _defineSectionInsert() {
    clearAll$();
    _ast.astSection = _ast.insert();
    _ast.astColumns = _ast.insert().columns();
    _ast.astTableNames = null;
    _activeExpression = null;
    _activeValues = _ast.insert().values();
  }

  void _defineSectionUpdate() {
    clearAll$();
    _ast.astSection = _ast.update();
    _ast.astColumns = null;
    _ast.astTableNames = null;
    _activeExpression = null;
    _activeValues = _ast.update().values();
  }

  void _defineSectionGroupBy() {
    _ast.astSection = _ast.groupBy();
    _ast.astColumns = _ast.groupBy().columns;
    _ast.astTableNames = null;
    _activeExpression = null;
    _activeValues = null;
  }

  void _defineSectionOrderBy() {
    _ast.astSection = _ast.orderBy();
    _ast.astColumns = _ast.orderBy().columns();
    _ast.astTableNames = null;
    _activeExpression = null;
    _activeValues = null;
  }

  ICQL _createJoin(JoinType joinType, String tableName) {
    _activeSection = Section.secJoin;
    final ICQLJoin join = _ast.joins().add;
    join.joinType = joinType;
    _ast.astName = join.joinedTable;
    _ast.astName!.name = tableName;
    _ast.astSection = join;
    _ast.astColumns = null;
//    _activeExpression = CQLCriteriaExpression(expression: join.condition);
    _activeExpression =
        injbr.get<ICQLCriteriaExpression>()(expression: join.condition);

    return this;
  }

  void _defineSectionWhere() {
    _ast.astSection = _ast.where();
    _ast.astColumns = null;
    _ast.astTableNames = null;
    // _activeExpression =
    //     CQLCriteriaExpression(expression: _ast.where().expression);
    _activeExpression = injbr.get<ICQLCriteriaExpression>()(
        expression: _ast.where().expression);
    _activeValues = null;
  }

  void _defineSectionHaving() {
    _ast.astSection = _ast.having();
    _ast.astColumns = null;
//    _ast.astTableNames = null;
    // _activeExpression =
    //     CQLCriteriaExpression(expression: _ast.having().expression);
    _activeExpression = injbr.get<ICQLCriteriaExpression>()(
        expression: _ast.having().expression);
    _activeValues = null;
  }
}
