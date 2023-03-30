import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';

class CQLSelectQualifiersMongoDB extends CQLSelectQualifiers {
  CQLSelectQualifiersMongoDB();

  @override
  String serializePagination() {
    // String result = '';
    // String first = '';
    // String skip = '';

    // for (final ICQLSelectQualifier element in qualifiers) {
    //   switch (element.qualifier) {
    //     case SelectQualifierType.sqFirst:
    //       first = Utils.instance.concat(['FIRST', element.value.toString()]);
    //       break;
    //     case SelectQualifierType.sqSkip:
    //       skip = Utils.instance.concat(['SKIP', element.value.toString()]);
    //       break;
    //     default:
    //       throw Exception(
    //           'CQLSelectQualifiersFirebase.SerializeSelectQualifiers: Unknown qualifier type');
    //   }
    // }
    // return Utils.instance.concat([result, first, skip]);
    return '';
  }
}
