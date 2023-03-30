import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';

class CQLSelectQualifiersSQLite extends CQLSelectQualifiers {
  CQLSelectQualifiersSQLite();

  @override
  String serializePagination() {
    String result = '';
    String first = '';
    String skip = '';

    for (final ICQLSelectQualifier element in qualifiers) {
      switch (element.qualifier) {
        case SelectQualifierType.sqFirst:
          first = Utils.instance.concat(['LIMIT', element.value.toString()]);
          break;
        case SelectQualifierType.sqSkip:
          skip = Utils.instance.concat(['OFFSET', element.value.toString()]);
          break;
        default:
          throw Exception(
              'CQLSelectQualifiersSQLite.SerializePagination: Unknown qualifier type');
      }
    }
    return Utils.instance.concat([result, first, skip]);
  }
}
