import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';
import 'package:flutter_cqlbr_firestore/src/cqlbr.where.firestore.dart';

class CQLSerializerFirestore extends CQLSerialize {
  @override
  T asResult<T extends Object>(ICQLAST ast) {
    late dynamic result;

    result = null;
    result ??= ast.select().serialize<CollectionReference>();
    result ??= ast.insert().serialize<CollectionReference>();
    result ??= ast.delete().serialize<DocumentReference>();
    result ??= ast.update().serialize<DocumentReference>();
    if (!ast.where().isEmpty()) {
      result = (ast.where() as CQLWhereFirestore).serialize<Query>(
          result is CollectionReference
              ? result
              : (result as DocumentReference).parent);
    }
    if (result is CollectionReference) {
      injbr.update<CollectionReference>((i) => result);
    } else {
      injbr.update<DocumentReference>((i) => result);
    }

    return result as T;
  }
}
