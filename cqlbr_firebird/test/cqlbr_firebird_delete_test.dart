import 'package:cqlbr_core/cqlbr_core.dart';
import 'package:cqlbr_firebird/cqlbr_firebird.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests -', () {
    CQLBr cqlbr = CQLBr(select: CQLSelectFirebird());

    test('TestDeleteFirebird', () {
      String result = cqlbr.delete$().from$('CLIENTES').asResult();

      expect(result, 'DELETE FROM CLIENTES');
    });

    test('TestDeleteWhereFirebird', () {
      String result =
          cqlbr.delete$().from$('CLIENTES').where$('ID_CLIENTE = 1').asResult();

      expect(result, 'DELETE FROM CLIENTES WHERE ID_CLIENTE = 1');
    });
  });
}
