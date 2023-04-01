import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';

class CQLSerializerMongoDB extends CQLSerialize {
  @override
  T asResult<T extends Object>(ICQLAST ast) {
    T result = super.asResult<T>(ast);
    result = Utils.instance
        .concat([result, ast.select().qualifiers.serializePagination()]) as T;
    return result;
  }
}