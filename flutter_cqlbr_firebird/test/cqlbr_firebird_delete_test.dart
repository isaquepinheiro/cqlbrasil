import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';
import 'package:flutter_cqlbr_firebird/flutter_cqlbr_firebird.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
}
