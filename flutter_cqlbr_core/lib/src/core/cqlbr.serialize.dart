import '../interface/cqlbr.interface.dart';
import 'cqlbr.utils.dart';

class CQLSerialize implements ICQLSerialize {
  @override
  T asResult<T extends Object>(ICQLAST ast) {
    return Utils.instance.concat([
      ast.select().serialize<T>(),
      ast.delete().serialize<T>(),
      ast.insert().serialize<T>(),
      ast.update().serialize<T>(),
      ast.joins().serialize<T>(),
      ast.where().serialize<T>(),
      ast.groupBy().serialize<T>(),
      ast.having().serialize<T>(),
      ast.orderBy().serialize<T>(),
    ]) as T;
  }
}
