import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';
import 'package:dart_cqlbr_db2/dart_cqlbr_db2.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests -', () {
    CQLBr cqlbr = CQLBr(select: CQLSelectDB2());

    test('TestDeleteDB2', () {
      String result = cqlbr.delete$().from$('CLIENTES').asResult();

      expect(result, 'DELETE FROM CLIENTES');
    });

    test('TestDeleteWhereDB2', () {
      String result =
          cqlbr.delete$().from$('CLIENTES').where$('ID_CLIENTE = 1').asResult();

      expect(result, 'DELETE FROM CLIENTES WHERE ID_CLIENTE = 1');
    });
  });
}
