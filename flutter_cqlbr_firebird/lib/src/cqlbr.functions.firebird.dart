import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';

class CQLFunctionsFirebird extends CQLFunctionAbstract {
  @override
  String substring(String value, int start, int length) {
    return 'SUBSTRING($value FROM $start FOR $length)';
  }

  @override
  String date(String value, [String format = 'yyyy-MM-dd']) {
    return format.isEmpty ? value : value;
  }

  @override
  String day(String value) {
    return 'EXTRACT(DAY FROM $value)';
  }

  @override
  String month(String value) {
    return 'EXTRACT(MONTH FROM $value)';
  }

  @override
  String year(String value) {
    return 'EXTRACT(YEAR FROM $value)';
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
