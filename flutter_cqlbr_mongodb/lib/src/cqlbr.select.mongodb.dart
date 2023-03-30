import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';

import 'cqlbr.delete.mongodb.dart';
import 'cqlbr.functions.mongodb.dart';
import 'cqlbr.insert.mongodb.dart';
import 'cqlbr.qualifier.mongodb.dart';
import 'cqlbr.serialize.mongodb.dart';
import 'cqlbr.update.mongodb.dart';

class CQLSelectMongoDB extends CQLSelect {
  CQLSelectMongoDB() {
    driver = Database.dbnMongoDB;
    qualifiers = CQLSelectQualifiersMongoDB();
    CQLBrRegister.instance.registerSelect(driver, this);
    CQLBrRegister.instance.registerInsert(driver, CQLInsertMongoDB());
    CQLBrRegister.instance.registerUpdate(driver, CQLUpdateMongoDB());
    CQLBrRegister.instance.registerDelete(driver, CQLDeleteMongoDB());
    CQLBrRegister.instance.registerSerialize(driver, CQLSerializerMongoDB());
    CQLBrRegister.instance.registerFunctions(driver, CQLFunctionsMongoDB());
  }

  @override
  String serialize() {
    late final String result;

    result = isEmpty()
        ? ''
        : Utils.instance.concat(
            [tableNames.serialize(), '.find( {', columns.serialize(), '} )'],
            delimiter: '');

    return result.toLowerCase();
  }
}
