import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';

import 'cqlbr.functions.db2.dart';
import 'cqlbr.qualifier.db2.dart';
import 'cqlbr.serialize.db2.dart';

class CQLSelectDB2 extends CQLSelect {
  CQLSelectDB2() {
    driver = Database.dbnMySQL;
    qualifiers = CQLSelectQualifiersDB2();
    CQLBrRegister.instance.registerSelect(driver, this);
    CQLBrRegister.instance.registerSerialize(driver, CQLSerializerDB2());
    CQLBrRegister.instance.registerFunctions(driver, CQLFunctionsDB2());
  }

  @override
  T? serialize<T extends Object>() {
    return isEmpty()
        ? '' as T
        : Utils.instance.concat([
            'SELECT',
            qualifiers.serializeDistinct(),
            columns.serialize(),
            'FROM',
            tableNames.serialize(),
          ]) as T;
  }
}
