# :hammer: Recursos do Criteria Quary Language

:heavy_check_mark: `Core`: ```Dependency on Packages```

:heavy_check_mark: `Package 1`: ```Firebase Database``` (Result Query)

:heavy_check_mark: `Package 2`: ```MySQL``` (Result String)

:heavy_check_mark: `Package 3`: ```SQLite``` (Result String)

:heavy_check_mark: `Package 3`: ```Firebase``` (Result String)

:heavy_check_mark: `Package 3`: ```DB2``` (Result String)

:heavy_check_mark: `Package 3`: ```MongoDB``` (Result String)


## CQLBr Interface

```Dart
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
  ICQL first$(int value);
  ICQL skip$(int value);
  ICQL limit$(int value);
  ICQL offset$(int value);
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
```
## Use Firebase

```dart
  CQLBr cqlbr = CQLBr(select: CQLSelectFirestore(instance1));

  cqlbr.select$()
       .all$()
       .from$('users')
       .where$('username').equal$('Bob 1')
       .and$('email').equal$('bob1@gmail.com')
       .or$('sobrenome').equal$('Sobrenome Bob 1')
       .orderBy$('username, sobrenome').desc$()
  .asResult();
```
## Use MySQL

```dart
  CQLBr cqlbr = CQLBr(select: CQLSelectMySQL());

  cqlbr.select$()
       .all$()
       .from$('users')
       .where$('username').equal$('Bob 1')
       .and$('email').equal$('bob1@gmail.com')
       .or$('sobrenome').equal$('Sobrenome Bob 1')
       .orderBy$('username, sobrenome').desc$()
  .asResult();
```