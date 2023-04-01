import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';

class CQLSelectQualifiersFirebird extends CQLSelectQualifiers {
  CQLSelectQualifiersFirebird();

  @override
  String serializePagination() {
    String result = '';
    String first = '';
    String skip = '';

    for (final ICQLSelectQualifier element in qualifiers) {
      switch (element.qualifier) {
        case SelectQualifierType.sqFirst:
          first = Utils.instance.concat(['FIRST', element.value.toString()]);
          break;
        case SelectQualifierType.sqSkip:
          skip = Utils.instance.concat(['SKIP', element.value.toString()]);
          break;
        default:
          throw Exception(
              'CQLSelectQualifiersFirebird.SerializeSelectQualifiers: Unknown qualifier type');
      }
    }
    return Utils.instance.concat([result, first, skip]);
  }
}
