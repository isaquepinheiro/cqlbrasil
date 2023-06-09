import 'package:cqlbr_core/cqlbr_core.dart';

import 'cqlbr.functions.sqlite.dart';
import 'cqlbr.qualifier.sqlite.dart';
import 'cqlbr.serialize.sqlite.dart';

class CQLSelectSQLite extends CQLSelect {
  CQLSelectSQLite() {
    driver = CQLDatabase.dbnSQLite;
    qualifiers = CQLSelectQualifiersSQLite();
    CQLBrRegister.instance.registerSelect(driver, this);
    CQLBrRegister.instance.registerSerialize(driver, CQLSerializerSQLite());
    CQLBrRegister.instance.registerFunctions(driver, CQLFunctionsSQLite());
  }
}
