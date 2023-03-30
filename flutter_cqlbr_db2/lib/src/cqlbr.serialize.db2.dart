import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';

class CQLSerializerDB2 extends CQLSerialize {
  @override
  T asResult<T extends Object>(ICQLAST ast) {
    T result = super.asResult<T>(ast);
    result = Utils.instance
        .concat([result, ast.select().qualifiers.serializePagination()]) as T;
    return result;
  }
}
