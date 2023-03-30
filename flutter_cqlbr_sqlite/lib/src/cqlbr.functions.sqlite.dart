import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';

class CQLFunctionsSQLite extends CQLFunctionAbstract {
  @override
  String substring(String value, int start, int length) {
    return 'SUBSTRING($value, $start, $length)';
  }

  @override
  String date(String value, [String format = 'yyyy-MM-dd']) {
    return format.isEmpty ? 'DATE($value)' : 'DATE($value)';
  }

  @override
  String day(String value) {
    return 'STRFTIME(%d, $value)';
  }

  @override
  String month(String value) {
    return 'STRFTIME(%m, $value)';
  }

  @override
  String year(String value) {
    return 'STRFTIME(%Y, $value)';
  }

  @override
  String concat(List<String> value) {
    String result = '';
    for (int i = 0; i < value.length; i++) {
      result += value[i];
      if (i < value.length - 1) {
        result += ' || ';
      }
    }

    return result;
  }
}
