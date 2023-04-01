import 'package:flutter/foundation.dart';
import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';
import 'cqlbr.delete.mongodb.dart';
import 'cqlbr.functions.mongodb.dart';
import 'cqlbr.insert.mongodb.dart';
import 'cqlbr.qualifier.mongodb.dart';
import 'cqlbr.serialize.mongodb.dart';
import 'cqlbr.update.mongodb.dart';

class CQLSelectMongoDB extends CQLSelect {
  CQLSelectMongoDB() {
    driver = CQLDatabase.dbnMongoDB;
    qualifiers = CQLSelectQualifiersMongoDB();
    CQLBrRegister.instance.registerSelect(driver, this);
    CQLBrRegister.instance.registerInsert(driver, CQLInsertMongoDB());
    CQLBrRegister.instance.registerUpdate(driver, CQLUpdateMongoDB());
    CQLBrRegister.instance.registerDelete(driver, CQLDeleteMongoDB());
    CQLBrRegister.instance.registerSerialize(driver, CQLSerializerMongoDB());
    CQLBrRegister.instance.registerFunctions(driver, CQLFunctionsMongoDB());
  }

  @override
  T? serialize<T extends Object>() {
    String result = '';

    if (!isEmpty()) {
      if (columns.count() > 0) {
        result = Utils.instance.concat([
          tableNames.serialize(), '.find({}, { ', _serializeNameValuePairsForUpdate(), ' })'
        ], delimiter: '');
      } else {
        result = Utils.instance
            .concat([tableNames.serialize(), '.find({})'], delimiter: '');
      }
    }

    return result as T;
  }

  @protected
  String _serializeNameValuePairsForUpdate() {
    String result = '';

    for (int i = 0; i < columns.count(); i++) {
      result = Utils.instance.concat(
        [
          result,
          Utils.instance.concat([columns.columns(i).name, ': 1'], delimiter: '')
        ],
        delimiter: ', ',
      );
    }

    return result.toLowerCase();
  }
}
