enum Operator {
  opeNone(name: 'opeNone'),
  opeWhere(name: 'opeWhere'),
  opeAnd(name: 'opeAnd'),
  opeOr(name: 'opeOr');

  final String name;

  const Operator({required this.name});
}

enum CQLDatabase {
  dbnSQLServer(name: 'dbnSQLServer'),
  dbnMySQL(name: 'dbnMySQL'),
  dbnPostgreSQL(name: 'dbnPostgreSQL'),
  dbnSQLite(name: 'dbnSQLite'),
  dbnOracle(name: 'dbnOracle'),
  dbnFirebird(name: 'dbnFirebird'),
  dbnInterbase(name: 'dbnInterbase'),
  dbnDB2(name: 'dbnDB2'),
  dbnMongoDB(name: 'dbnMongoDB'),
  dbnFirestore(name: 'dbnFirestore'),
  dbnASA(name: 'dbnASA'),
  dbnInformix(name: 'dbnInformix'),
  dbnNexusDB(name: 'dbnNexusDB'),
  dbnCassandra(name: 'dbnCassandra'),
  dbnADs(name: 'dbnADs');

  final String name;

  const CQLDatabase({required this.name});
}

enum CQLExpressionOperation {
  eoNone(name: 'eoNone'),
  eoAnd(name: 'eoAnd'),
  eoOr(name: 'eoOr'),
  eoOperation(name: 'eoOperation'),
  eoFunction(name: 'eoFunction');

  final String name;

  const CQLExpressionOperation({required this.name});
}

abstract class ICQLExpression {
  ICQLExpression? get left;
  set left(ICQLExpression? value);
  ICQLExpression? get right;
  set right(ICQLExpression? value);
  dynamic get term;
  set term(dynamic value);
  CQLExpressionOperation get operation;
  set operation(CQLExpressionOperation value);
  CQLOperatorCompare get compare;
  set compare(CQLOperatorCompare value);
  T? serialize<T extends Object>([bool addParens = false]);
  bool isEmpty();
  void copyWith(ICQLExpression node);
  void clear();
}

abstract class ICQLCriteriaExpression {
  ICQLCriteriaExpression and(ICQLOperator expression);
  ICQLCriteriaExpression or(ICQLOperator expression);
  ICQLCriteriaExpression ope(ICQLOperator expression);
  ICQLCriteriaExpression func(dynamic expression);
  ICQLExpression? get expression;
  ICQLCriteriaExpression call(
      {ICQLExpression? expression, String expressionStr = ''});
  // set expression$(ICQLExpression? value);
  // ICQLExpression? get lastAnd;
  // set lastAnd(ICQLExpression? value);
  T asResult<T extends Object>();
}

abstract class ICQLCaseWhenThen {
  ICQLExpression get whenExpression;
  set whenExpression(ICQLExpression value);
  ICQLExpression get thenExpression;
  set thenExpression(ICQLExpression value);
}

abstract class ICQLCaseWhenList {
  ICQLCaseWhenThen whenThen(int idx);
  intsetWhenThen(int idx, ICQLCaseWhenThen value);
  ICQLCaseWhenThen add();
  int setAdd(ICQLCaseWhenThen whenThen);
  int count();
}

abstract class ICQLCase {
  ICQLExpression get caseExpression;
  set caseExpression(ICQLExpression value);
  ICQLExpression get elseExpression;
  set elseExpression(ICQLExpression value);
  ICQLCaseWhenList get whenList;
  set whenList(ICQLCaseWhenList value);
  T serialize<T extends Object>();
}

abstract class ICQLFunctions {
  String count(String value);
  String lower(String value);
  String min(String value);
  String max(String value);
  String upper(String value);
  String substring(String value, int start, int length);
  String date(String value, [String format]);
  String day(String value);
  String month(String value);
  String year(String value);
  String concat(List<String> value);
}

abstract class ICQL {
  ICQL and$(dynamic expression);
  ICQL as$(String alias);
  ICQLCriteriaCase case$(dynamic expression);
  ICQL on$(dynamic expression);
  ICQL or$(dynamic expression);
  ICQL set$(String columnName, dynamic columnValue);
  ICQL all$();
  ICQL asc$();
  ICQL clear$();
  ICQL clearAll$();
  ICQL column$([dynamic columnName = '', String tableName = '']);
  ICQL delete$();
  ICQL desc$();
  ICQL distinct$();
  ICQLCriteriaExpression expression$(dynamic term);
  ICQL from$(dynamic tableName, [String alias = '']);
  ICQL groupBy$(dynamic columnName);
  ICQL having$(dynamic expression);
  ICQL fullJoin$(String tableName, [String alias = '']);
  ICQL leftJoin$(String tableName, [String alias = '']);
  ICQL rightJoin$(String tableName, [String alias = '']);
  ICQL innerJoin$(String tableName, [String alias = '']);
  ICQL insert$();
  ICQL into$(String tableName);
  bool isEmpty$();
  ICQL orderBy$(dynamic columnName);
  ICQL select$([dynamic columnName = '']);
  // ICQL first$(int value);
  // ICQL skip$(int value);
  // ICQL limit$(int value);
  // ICQL offset$(int value);
  ICQL pageSize(int value);
  ICQL pagePosition<T>(T value);
  ICQL update$(String tableName);
  ICQL where$([dynamic expression = '']);
  ICQL values$(String columnName, dynamic columnValue);
  // Operations functions
  ICQL equal$([dynamic value = '']);
  ICQL notEqual$(dynamic value);
  ICQL greaterThan$(dynamic value);
  ICQL greaterEqThan$(dynamic value);
  ICQL lessThan$(dynamic value);
  ICQL lessEqThan$(dynamic value);
  ICQL isNull$();
  ICQL isNotNull$();
  ICQL like$(String value);
  ICQL likeLeft$(String value);
  ICQL likeRight$(String value);
  ICQL notLike$(String value);
  ICQL notLikeLeft$(String value);
  ICQL notLikeRight$(String value);
  ICQL notLikeFull$(String value);
  ICQL in$(dynamic value);
  ICQL notIn$(dynamic value);
  ICQL exists$(String value);
  ICQL notExists$(String value);
  ICQL count$();
  ICQL lower$();
  ICQL min$();
  ICQL max$();
  ICQL upper$();
  ICQL substring$(int start, int length);
  ICQL date$(String value);
  ICQL day$(String value);
  ICQL month$(String value);
  ICQL year$(String value);
  ICQL concat$(List<String> value);
  ICQLFunctions asFun$();
  T asResult<T extends Object>();
}

abstract class ICQLCriteriaCase {
  ICQLCriteriaCase and$(dynamic expression);
  ICQLCriteriaCase or$(dynamic expression);
  ICQLCriteriaCase else$(dynamic value);
  ICQLCriteriaCase then$(dynamic value);
  ICQLCriteriaCase when$(dynamiccondition);
  ICQLCase get case$;
  ICQL end$();
}

abstract class ICQLName {
  String get name;
  set name(String value);
  ICQLCase get cAse;
  set case$(ICQLCase value);
  String get alias;
  set alias(String value);
  T serialize<T extends Object>();
  bool isEmpty();
  void clear();
}

abstract class ICQLNames {
  ICQLName add();
  void setAdd(ICQLName value);
  ICQLName columns(int idx);
  int count();
  bool isEmpty();
  T serialize<T extends Object>();
  void clear();
}

abstract class ICQLSection {
  String get name;
  bool isEmpty();
  void clear();
}

abstract class ICQLSelect extends ICQLSection {
  ICQLNames get columns;
  ICQLNames get tableNames;
  ICQLSelectQualifiers get qualifiers;
  CQLDatabase get driver;
  set driver(CQLDatabase value);
  T? serialize<T extends Object>();
}

abstract class ICQLWhere extends ICQLSection {
  ICQLExpression get expression;
  set expression(ICQLExpression value);
  T? serialize<T extends Object>();
}

abstract class ICQLOrderBy extends ICQLSection {
  ICQLNames columns();
  T? serialize<T extends Object>();
}

abstract class ICQLDelete extends ICQLSection {
  ICQLNames get tableNames;
  T? serialize<T extends Object>();
}

enum JoinType {
  jtInner(name: 'Inner'),
  jtLeft(name: 'Left'),
  jtRight(name: 'Right'),
  jtFull(name: 'Full');

  final String name;

  const JoinType({required this.name});
}

abstract class ICQLJoin extends ICQLSection {
  ICQLExpression get condition;
  set condition(ICQLExpression value);
  ICQLName get joinedTable;
  set joinedTable(ICQLName value);
  JoinType get joinType;
  set joinType(JoinType value);
}

abstract class ICQLGroupBy extends ICQLSection {
  ICQLNames get columns;
  T serialize<T extends Object>();
}

abstract class ICQLHaving extends ICQLSection {
  ICQLExpression get expression;
  set expression(ICQLExpression value);
  T serialize<T extends Object>();
}

abstract class ICQLNameValuePairs {
  ICQLNameValue add();
  setAdd(ICQLNameValue value);
  ICQLNameValue item(int idx);
  bool isEmpty();
  int count();
  void clear();
}

abstract class ICQLInsert extends ICQLSection {
  String get tableName;
  set tableName(String value);
  ICQLNames columns();
  ICQLNameValuePairs values();
  T? serialize<T extends Object>();
}

abstract class ICQLUpdate extends ICQLSection {
  String get tableName;
  set tableName(String value);
  ICQLNameValuePairs values();
  T? serialize<T extends Object>();
}

enum OrderByDirection {
  dirNone(name: ''),
  dirAscending(name: 'Asc'),
  dirDescending(name: 'Desc');

  final String name;

  const OrderByDirection({required this.name});
}

abstract class ICQLOrderByColumn extends ICQLName {
  OrderByDirection get direction;
  set direction(OrderByDirection value);
}

enum SelectQualifierType {
  // sqFirst(name: 'First'),
  sqPaging(name: 'Paging'),
  sqSkip(name: 'Skip'),
  sqDistinct(name: 'Distinct');

  final String name;

  const SelectQualifierType({required this.name});
}

abstract class ICQLSelectQualifier {
  SelectQualifierType get qualifier;
  set qualifier(SelectQualifierType value);
  dynamic get value;
  set value(dynamic value);
}

abstract class ICQLSelectQualifiers {
  ICQLSelectQualifier add();
  setAdd(ICQLSelectQualifier value);
  ICQLSelectQualifier qualifier(int idx);
  bool isEmpty();
  int count();
  bool executingPagination();
  T? serializePagination<T extends Object>();
  String serializeDistinct();
  void clear();
}

abstract class ICQLJoins {
  ICQLJoin get add;
  set add(ICQLJoin value);
  ICQLJoin joins(int idx);
  setJoins(int idx, ICQLJoin value);
  bool isEmpty();
  int count();
  T serialize<T extends Object>();
  void clear();
}

abstract class ICQLNameValue {
  String get name;
  set name(String value);
  dynamic get value;
  set value(dynamic value);
  bool isEmpty();
  void clear();
}

abstract class ICQLAST {
  ICQLNames? get astColumns;
  set astColumns(ICQLNames? value);
  ICQLSection? get astSection;
  set astSection(ICQLSection? value);
  ICQLName? get astName;
  set astName(ICQLName? value);
  ICQLNames? get astTableNames;
  set astTableNames(ICQLNames? value);
  ICQLSelect select();
  ICQLDelete delete();
  ICQLInsert insert();
  ICQLUpdate update();
  ICQLJoins joins();
  ICQLGroupBy groupBy();
  ICQLHaving having();
  ICQLOrderBy orderBy();
  ICQLWhere where();
  void clear();
  bool isEmpty();
}

abstract class ICQLSerialize {
  T asResult<T extends Object>(ICQLAST ast);
}

enum CQLOperatorCompare {
  fcNone(name: ''),
  fcEqual(name: '='),
  fcNotEqual(name: '<>'),
  fcGreater(name: '>'),
  fcGreaterEqual(name: '>='),
  fcLess(name: '<'),
  fcLessEqual(name: '<='),
  fcIn(name: 'In'),
  fcNotIn(name: 'Not In'),
  fcIsNull(name: 'Is Null'),
  fcIsNotNull(name: 'Is Not Null'),
  fcBetween(name: 'Between'),
  fcNotBetween(name: 'Not Between'),
  fcExists(name: 'Exists'),
  fcNotExists(name: 'Not Exists'),
  fcLikeFull(name: 'Like Full'),
  fcLikeLeft(name: 'Like Left'),
  fcLikeRight(name: 'Like Right'),
  fcNotLikeFull(name: 'Not Like Full'),
  fcNotLikeLeft(name: 'Not Like Left'),
  fcNotLikeRight(name: 'Not Like Right'),
  fcLike(name: 'Like'),
  fcNotLike(name: 'Not Like');

  final String name;

  const CQLOperatorCompare({required this.name});
}

enum CQLDataFieldType {
  dftUnknown(name: 'Null'),
  dftString(name: 'String'),
  dftInteger(name: 'Integer'),
  dftFloat(name: 'Float'),
  dftDate(name: 'Date'),
  dftArray(name: 'Array'),
  dftText(name: 'Text'),
  dftBoolean(name: 'Boolean'),
  dftDateTime(name: 'DateTime'),
  dftGuid(name: 'Guid');

  final String name;

  const CQLDataFieldType({required this.name});
}

abstract class ICQLOperator {
  CQLOperatorCompare get compare;
  set compare(CQLOperatorCompare value);
  String get columnName;
  set columnName(String value);
  dynamic get value;
  set value(dynamic value);
  CQLDataFieldType get dataType;
  set dataType(CQLDataFieldType value);
}

abstract class ICQLOperators {
  ICQLOperator isEqual(dynamic value);
  ICQLOperator isNotEqual(dynamic value);
  ICQLOperator isGreaterThan(dynamic value);
  ICQLOperator isGreaterEqThan(dynamic value);
  ICQLOperator isLessThan(dynamic value);
  ICQLOperator isLessEqThan(dynamic value);
  ICQLOperator isNull();
  ICQLOperator isNotNull();
  ICQLOperator isLike(String value);
  ICQLOperator isLikeFull(String value);
  ICQLOperator isLikeLeft(String value);
  ICQLOperator isLikeRight(String value);
  ICQLOperator isNotLike(String value);
  ICQLOperator isNotLikeFull(String value);
  ICQLOperator isNotLikeLeft(String value);
  ICQLOperator isNotLikeRight(String value);
  ICQLOperator isIn(dynamic value);
  ICQLOperator isNotIn(dynamic value);
  ICQLOperator isExists(String value);
  ICQLOperator isNotExists(String value);
}