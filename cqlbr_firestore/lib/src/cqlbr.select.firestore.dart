//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cqlbr_core/cqlbr_core.dart';

import 'cqlbr.delete.firestore.dart';
import 'cqlbr.insert.firestore.dart';
import 'cqlbr.qualifier.firestore.dart';
import 'cqlbr.serialize.firestore.dart';
import 'cqlbr.update.firestore.dart';
import 'cqlbr.where.firestore.dart';
import 'cqlbr.orderby.firestore.dart';

class CQLSelectFirestore extends CQLSelect {
  late final FirebaseFirestore instance;

  CQLSelectFirestore(this.instance) {
    driver = CQLDatabase.dbnFirestore;
    qualifiers = CQLSelectQualifiersFirestore();
    CQLBrRegister.instance.registerSelect(driver, this);
    CQLBrRegister.instance.registerDelete(driver, CQLDeleteFirestore(instance));
    CQLBrRegister.instance.registerInsert(driver, CQLInsertFirestore(instance));
    CQLBrRegister.instance.registerUpdate(driver, CQLUpdateFirestore(instance));
    CQLBrRegister.instance.registerWhere(driver, CQLWhereFirestore());
    CQLBrRegister.instance.registerOrderBy(driver, CQLOrderByFirestore());
    CQLBrRegister.instance.registerSerialize(driver, CQLSerializerFirestore());
    CQLBrRegister.instance
        .registerFunctions(driver, CQLFunctions(database: driver));
  }

  @override
  T? serialize<T extends Object>() {
    return isEmpty()
        ? null
        : instance.collection(tableNames.serialize<String>()) as T;
  }

  Map<String, dynamic> toMap() {
    return (CQLBrRegister.instance.insert(driver) as CQLInsertFirestore)
        .toMap();
  }
}
