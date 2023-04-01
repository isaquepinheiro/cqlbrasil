import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';
import 'package:flutter_cqlbr_sqlite/flutter_cqlbr_sqlite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  CQLBr cqlbr = CQLBr(select: CQLSelectSQLite());

  test('TestSelectAll', () {
    String result =
        cqlbr.select$().all$().from$('CLIENTES').as$('CLI').asResult();
    expect(result, 'SELECT * FROM CLIENTES AS CLI');
  });

  test('TestSelectAllWhere', () {
    String result = cqlbr
        .select$()
        .all$()
        .from$('CLIENTES')
        .where$('ID_CLIENTE = 1')
        .asResult();
    expect(result, 'SELECT * FROM CLIENTES WHERE ID_CLIENTE = 1');
  });

  test('TestSelectAllWhereAndOr', () {
    String result = cqlbr
        .select$()
        .all$()
        .from$('CLIENTES')
        .where$('ID_CLIENTE = 1')
        .and$('ID')
        .greaterEqThan$(10)
        .or$('ID')
        .lessEqThan$(20)
        .asResult();
    expect(result,
        'SELECT * FROM CLIENTES WHERE (ID_CLIENTE = 1) AND ((ID >= 10) OR (ID <= 20))');
  });

  test('TestSelectAllWhereAndAnd', () {
    String result = cqlbr
        .select$()
        .all$()
        .from$('CLIENTES')
        .where$('ID_CLIENTE = 1')
        .and$('ID')
        .greaterEqThan$(10)
        .and$('ID')
        .lessEqThan$(20)
        .asResult();
    expect(result,
        'SELECT * FROM CLIENTES WHERE (ID_CLIENTE = 1) AND (ID >= 10) AND (ID <= 20)');
  });

  test('TestSelectAllOrderBy', () {
    String result = cqlbr
        .select$()
        .all$()
        .from$('CLIENTES')
        .orderBy$('ID_CLIENTE')
        .asResult();
    expect(result, 'SELECT * FROM CLIENTES ORDER BY ID_CLIENTE');
  });

  test('TestSelectColumns', () {
    String result = cqlbr
        .select$()
        .column$('ID_CLIENTE')
        .column$('NOME_CLIENTE')
        .from$('CLIENTES')
        .orderBy$('NOME_CLIENTE')
        .asResult();
    expect(result,
        'SELECT ID_CLIENTE, NOME_CLIENTE FROM CLIENTES ORDER BY NOME_CLIENTE');
  });

  test('TestSelectColumnsCase', () {
    String result = cqlbr
        .select$()
        .column$('ID_CLIENTE')
        .column$('NOME_CLIENTE')
        .column$('TIPO_CLIENTE')
        .case$(null)
        .when$('0')
        .then$(Fun.q('FISICA'))
        .when$('1')
        .then$(Fun.q('JURIDICA'))
        .else$(Fun.q('PRODUTOR'))
        .end$()
        .as$('TIPO_PESSOA')
        .from$('CLIENTES')
        .asResult();
    expect(result,
        "SELECT ID_CLIENTE, NOME_CLIENTE, (CASE TIPO_CLIENTE WHEN 0 THEN 'FISICA' WHEN 1 THEN 'JURIDICA' ELSE 'PRODUTOR' END) AS TIPO_PESSOA FROM CLIENTES");
  });
}
