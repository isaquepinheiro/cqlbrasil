import 'package:flutter_cqlbr_core/src/core/cqlbr.delete.dart';
import 'package:flutter_cqlbr_core/src/core/cqlbr.insert.dart';
import 'package:flutter_cqlbr_core/src/core/cqlbr.where.dart';

import '../interface/cqlbr.interface.dart';
import 'cqlbr.operators.dart';
import 'cqlbr.update.dart';

class CQLBrRegister {
  late final Map<CQLDatabase, ICQLSelect> cqlSelect;
  late final Map<CQLDatabase, ICQLInsert> cqlInsert;
  late final Map<CQLDatabase, ICQLUpdate> cqlUpdate;
  late final Map<CQLDatabase, ICQLDelete> cqlDelete;
  late final Map<CQLDatabase, ICQLWhere> cqlWhere;
  late final Map<CQLDatabase, ICQLSerialize> cqlSerialize;
  late final Map<CQLDatabase, ICQLFunctions> cqlFunctions;
  late final Map<CQLDatabase, ICQLOperators> cqlOperators;

  static CQLBrRegister? _instance;

  CQLBrRegister._() {
    cqlSelect = {};
    cqlInsert = {};
    cqlUpdate = {};
    cqlDelete = {};
    cqlWhere = {};
    cqlSerialize = {};
    cqlFunctions = {};
    cqlOperators = {};
  }

  static CQLBrRegister get instance => _instance ??= CQLBrRegister._();

  void registerSelect(CQLDatabase database, ICQLSelect select) {
    cqlSelect[database] = select;
  }

  void registerInsert(CQLDatabase database, ICQLInsert insert) {
    cqlInsert[database] = insert;
  }

  void registerUpdate(CQLDatabase database, ICQLUpdate update) {
    cqlUpdate[database] = update;
  }

  void registerDelete(CQLDatabase database, ICQLDelete delete) {
    cqlDelete[database] = delete;
  }

  void registerWhere(CQLDatabase database, ICQLWhere where) {
    cqlWhere[database] = where;
  }

  void registerSerialize(CQLDatabase database, ICQLSerialize serialize) {
    cqlSerialize[database] = serialize;
  }

  void registerFunctions(CQLDatabase database, ICQLFunctions functions) {
    cqlFunctions[database] = functions;
  }

  void registerOperators(CQLDatabase database, ICQLOperators operators) {
    cqlOperators[database] = operators;
  }

  ICQLSelect select(CQLDatabase database) {
    if (!cqlSelect.containsKey(database)) {
      throw Exception('Select not registered for database: $database');
    }
    return cqlSelect[database]!;
  }

  ICQLInsert insert(CQLDatabase database) {
    return cqlInsert[database] ?? CQLInsert();
  }

  ICQLUpdate update(CQLDatabase database) {
    return cqlUpdate[database] ?? CQLUpdate();
  }

  ICQLDelete delete(CQLDatabase database) {
    return cqlDelete[database] ?? CQLDelete();
  }

  ICQLWhere where(CQLDatabase database) {
    return cqlWhere[database] ?? CQLWhere();
  }

  ICQLSerialize serialize(CQLDatabase database) {
    if (!cqlSerialize.containsKey(database)) {
      throw Exception('Serialize not registered for database: $database');
    }
    return cqlSerialize[database]!;
  }

  ICQLFunctions? functions(CQLDatabase database) {
    return cqlFunctions[database];
  }

  ICQLOperators operators(CQLDatabase database) {
    return cqlOperators[database] ?? CQLOperators(database: database);
  }
}
