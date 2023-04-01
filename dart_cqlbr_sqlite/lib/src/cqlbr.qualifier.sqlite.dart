import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';

class CQLSelectQualifiersSQLite extends CQLSelectQualifiers {
  CQLSelectQualifiersSQLite();

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
              'CQLSelectQualifiersSQLite.SerializePagination: Unknown qualifier type');
      }
    }
    return Utils.instance.concat([result, paging, skip]) as T;
  }
}
