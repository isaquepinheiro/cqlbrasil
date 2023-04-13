import 'package:cqlbr_core/cqlbr_core.dart';

class CQLSerializerCassandra extends CQLSerialize {
  @override
  T asResult<T extends Object>(ICQLAST ast) {
    T result = super.asResult<T>(ast);
    result = Utils.instance
        .concat([result, ast.select().qualifiers.serializePagination<String>()]) as T;
    return result;
  }
}
