import '../interface/cqlbr.interface.dart';
import 'cqlbr.functions.abstract.dart';
import 'cqlbr.register.dart';

class CQLFunctions extends CQLFunctionAbstract implements ICQLFunctions {
  late final CQLDatabase database;

  CQLFunctions({
    required this.database,
  });

  static String q(String value) {
    return '\'$value\'';
  }

  @override
  String concat(List<String> value) {
    return CQLBrRegister.instance.functions(database)!.concat(value);
  }

  @override
  String count(String value) {
    return 'COUNT($value)';
  }

  @override
  String date(String value, [String format = 'yyyy-MM-dd']) {
    return CQLBrRegister.instance.functions(database)!.date(value, format);
  }

  @override
  String day(String value) {
    return CQLBrRegister.instance.functions(database)!.day(value);
  }

  @override
  String lower(String value) {
    return 'LOWER($value)';
  }

  @override
  String max(String value) {
    return 'MAX($value)';
  }

  @override
  String min(String value) {
    return 'MIN($value)';
  }

  @override
  String month(String value) {
    return CQLBrRegister.instance.functions(database)!.month(value);
  }

  @override
  String substring(String value, int start, int length) {
    return CQLBrRegister.instance
        .functions(database)!
        .substring(value, start, length);
  }

  @override
  String upper(String value) {
    return 'UPPER($value)';
  }

  @override
  String year(String value) {
    return CQLBrRegister.instance.functions(database)!.year(value);
  }
}
