import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';

class CQLFunctionsDB2 extends CQLFunctionAbstract {
  @override
  String substring(String value, int start, int length) {
    return 'SUBSTRING($value, $start, $length)';
  }

  @override
  String date(String value, [String format = 'yyyy-MM-dd']) {
    return format.isEmpty ? value : 'DATE_FORMAT($value, $format)';
  }

  @override
  String day(String value) {
    return 'DAY($value)';
  }

  @override
  String month(String value) {
    return 'MONTH($value)';
  }

  @override
  String year(String value) {
    return 'YEAR($value)';
  }

  @override
  String concat(List<String> value) {
    String result = '';
    for (int i = 0; i < value.length; i++) {
      result += value[i];
      if (i < value.length - 1) {
        result += ', ';
      }
    }

    return 'CONCAT($result)';
  }
}
