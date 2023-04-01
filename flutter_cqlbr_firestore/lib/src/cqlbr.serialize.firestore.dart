import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';
import 'package:flutter_cqlbr_firestore/src/cqlbr.where.firestore.dart';

import 'cqlbr.orderby.firestore.dart';

class CQLSerializerFirestore extends CQLSerialize {
  @override
  T asResult<T extends Object>(ICQLAST ast) {
    late dynamic result;

    result = null;
    result ??= ast.select().serialize<Query>();
    result ??= ast.insert().serialize<Query>();
    result ??= ast.delete().serialize<DocumentReference>();
    result ??= ast.update().serialize<DocumentReference>();
    if (!ast.where().isEmpty()) {
      result = (ast.where() as CQLWhereFirestore).serialize<Query>(
          (result is Query)
              ? result
              : (result as DocumentReference).parent);
    }
    if (!ast.orderBy().isEmpty()) {
      result = (ast.orderBy() as CQLOrderByFirestore).serialize<Query>(
          (result is Query)
              ? result
              : (result as DocumentReference).parent);
    }
    (result is Query)
        ? injbr.update<Query>((i) => result)
        : injbr.update<DocumentReference>((i) => result);

    return result as T;
  }
}
