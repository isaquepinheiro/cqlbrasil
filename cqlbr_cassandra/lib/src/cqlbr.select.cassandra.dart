import 'package:cqlbr_core/cqlbr_core.dart';

import 'cqlbr.functions.cassandra.dart';
import 'cqlbr.qualifier.cassandra.dart';
import 'cqlbr.serialize.cassandra.dart';

class CQLSelectCassandra extends CQLSelect {
  CQLSelectCassandra() {
    driver = CQLDatabase.dbnCassandra;
    qualifiers = CQLSelectQualifiersCassandra();
    CQLBrRegister.instance.registerSelect(driver, this);
    CQLBrRegister.instance.registerSerialize(driver, CQLSerializerCassandra());
    CQLBrRegister.instance.registerFunctions(driver, CQLFunctionsCassandra());
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
