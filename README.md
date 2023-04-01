## Criteria Query Language Brasil (Dart/Flutter)

CQLBr é um framework opensource que provê escritas gerando o script SQL, através de uma interface, permitindo mapear de forma orientada a objeto, toda sintaxe de comandos SQL (SELECT, INSERT, UPDATE e DELETE), para banco de dados relacional.

Durante o desenvolvimento de software, é evidente a preocupação em que se tem em aumentar a produtividade e manter a compatibilidade entre os possíveis bancos que um sistema pode usar. No que se refere a sintaxe de banco de dados, temos em alguns casos, incompatibilidades entre comandos SQL, exigindo assim, a necessidade de um maior controle na escrita de cada banco, e foi para ajudar nesse ponto crítico que CQLBr nasceu, ele foi projetado para que a escrita de querys seja única, de forma funcional e orientada a objeto, possibilitando assim a mesma escrita feita pelo framework, gerar querys diferentes conforme o banco selecionado, o qual pode ser mudado de forma muito simples, bastando selecionar um dos modelos implementados no CQLBr Framework, sem ter que re-faturar diversas querys espalhadas pelas milhares de linhas de código.

<img src="https://www.isaquepinheiro.com.br/projetos/cqlbr-framework-for-delphilazarus-65199.png" width="1280" height="500">

# :hammer: Recursos do Criteria Quary Language

:heavy_check_mark: `Core`: ```Dependency on Packages```

:heavy_check_mark: `Package 1`: ```Firebase Database``` (Result Query)

:heavy_check_mark: `Package 2`: ```MySQL``` (Result String)

:heavy_check_mark: `Package 3`: ```SQLite``` (Result String)

:heavy_check_mark: `Package 3`: ```Firebase``` (Result String)

:heavy_check_mark: `Package 3`: ```DB2``` (Result String)


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
