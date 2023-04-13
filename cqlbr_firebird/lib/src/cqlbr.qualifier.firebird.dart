import 'package:cqlbr_core/cqlbr_core.dart';

class CQLSelectQualifiersFirebird extends CQLSelectQualifiers {
  CQLSelectQualifiersFirebird();

  @override
  T? serializePagination<T extends Object>() {
    String result = '';
    String paging = '';
    String skip = '';

    for (final ICQLSelectQualifier element in qualifiers) {
      switch (element.qualifier) {
        case SelectQualifierType.sqPaging:
          paging = Utils.instance.concat(['FIRST', element.value.toString()]);
          break;
        case SelectQualifierType.sqSkip:
          skip = Utils.instance.concat(['SKIP', element.value.toString()]);
          break;
        default:
          throw Exception(
              'CQLSelectQualifiersFirebird.SerializeSelectQualifiers: Unknown qualifier type');
      }
    }
    return Utils.instance.concat([result, paging, skip]) as T;
  }
}
