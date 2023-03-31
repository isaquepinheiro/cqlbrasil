import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';

import 'cqlbr.functions.firebird.dart';
import 'cqlbr.qualifier.firebird.dart';
import 'cqlbr.serialize.firebird.dart';

class CQLSelectFirebird extends CQLSelect {
  CQLSelectFirebird() {
    driver = CQLDatabase.dbnFirebird;
    qualifiers = CQLSelectQualifiersFirebird();
    CQLBrRegister.instance.registerSelect(driver, this);
    CQLBrRegister.instance.registerSerialize(driver, CQLSerializerFirebird());
    CQLBrRegister.instance.registerFunctions(driver, CQLFunctionsFirebird());
  }
}
