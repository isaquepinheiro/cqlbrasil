import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';

class CQLSelectQualifiersMySQL extends CQLSelectQualifiers {
  CQLSelectQualifiersMySQL();

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
              'CQLSelectQualifiersMySQL.SerializeSelectQualifiers: Unknown qualifier type');
      }
    }
    return Utils.instance.concat([result, first, skip]);
  }
}