import 'package:cqlbr_core/cqlbr_core.dart';

class CQLSelectQualifiersMySQL extends CQLSelectQualifiers {
  CQLSelectQualifiersMySQL();

  @override
  T? serializePagination<T extends Object>() {
    String result = '';
    String paging = '';
    String skip = '';

    for (final ICQLSelectQualifier element in qualifiers) {
      switch (element.qualifier) {
        case SelectQualifierType.sqPaging:
          paging = Utils.instance.concat(['LIMIT', element.value.toString()]);
          break;
        case SelectQualifierType.sqSkip:
          skip = Utils.instance.concat(['OFFSET', element.value.toString()]);
          break;
        default:
          throw Exception(
              'CQLSelectQualifiersMySQL.SerializeSelectQualifiers: Unknown qualifier type');
      }
    }
    return Utils.instance.concat([result, paging, skip]) as T;
  }
}
