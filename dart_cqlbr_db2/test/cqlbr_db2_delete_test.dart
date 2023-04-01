import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';
import 'package:flutter_cqlbr_db2/flutter_cqlbr_db2.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
}
