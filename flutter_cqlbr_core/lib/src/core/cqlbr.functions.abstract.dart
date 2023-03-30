import '../interface/cqlbr.interface.dart';

class CQLFunctionAbstract implements ICQLFunctions {
  @override
  String concat(List<String> value) {
    throw '[ $runtimeType.concat() ] Child class needs to implement this method';
  }

  @override
  String count(String value) {
    throw '[ $runtimeType.count() ] Child class needs to implement this method';
  }

  @override
  String date(String value, [String format = 'yyyy-MM-dd']) {
    throw '[ $runtimeType.date() ] Child class needs to implement this method';
  }

  @override
  String day(String value) {
    throw '[ $runtimeType.day() ] Child class needs to implement this method';
  }

  @override
  String lower(String value) {
    throw '[ $runtimeType.lower() ] Child class needs to implement this method';
  }

  @override
  String max(String value) {
    throw '[ $runtimeType.max() ] Child class needs to implement this method';
  }

  @override
  String min(String value) {
    throw '[ $runtimeType.min() ] Child class needs to implement this method';
  }

  @override
  String month(String value) {
    throw '[ $runtimeType.month() ] Child class needs to implement this method';
  }

  @override
  String substring(String value, int start, int length) {
    throw '[ $runtimeType.substring() ] Child class needs to implement this method';
  }

  @override
  String upper(String value) {
    throw '[ $runtimeType.upper() ] Child class needs to implement this method';
  }

  @override
  String year(String value) {
    throw '[ $runtimeType.year() ] Child class needs to implement this method';
  }
}
