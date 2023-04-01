import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';
import 'package:dart_cqlbr_firestore/dart_cqlbr_firestore.dart';

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
    if (!ast.select().qualifiers.isEmpty()){
    result = (ast.select().qualifiers as CQLSelectQualifiersFirestore).serializePagination<Query>(
      (result is Query)
              ? result
              : (result as DocumentReference).parent);}
    (result is Query)
        ? injbr.update<Query>((i) => result)
        : injbr.update<DocumentReference>((i) => result);

    return result as T;
  }
}
