import 'package:cqlbr_core/cqlbr_core.dart';
import 'package:cqlbr_firebird/cqlbr_firebird.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests -', () {
    CQLBr cqlbr = CQLBr(select: CQLSelectFirebird());

    test('TestCountFirebird', () {
      String result = cqlbr
          .select$()
          .column$('ID_CLIENTE')
          .count$()
          .as$('IDCOUNT')
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT COUNT(ID_CLIENTE) AS IDCOUNT FROM CLIENTES');
    });

    test('TestLowerFirebird', () {
      String result = cqlbr
          .select$()
          .column$('NOME_CLIENTE')
          .lower$()
          .as$('NOME')
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT LOWER(NOME_CLIENTE) AS NOME FROM CLIENTES');
    });

    test('TestUpperFirebird', () {
      String result = cqlbr
          .select$()
          .column$('NOME_CLIENTE')
          .upper$()
          .as$('NOME')
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT UPPER(NOME_CLIENTE) AS NOME FROM CLIENTES');
    });

    test('TestMaxFirebird', () {
      String result = cqlbr
          .select$()
          .column$('ID_CLIENTE')
          .max$()
          .as$('IDCOUNT')
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT MAX(ID_CLIENTE) AS IDCOUNT FROM CLIENTES');
    });

    test('TestMinFirebird', () {
      String result = cqlbr
          .select$()
          .column$('ID_CLIENTE')
          .min$()
          .as$('IDCOUNT')
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT MIN(ID_CLIENTE) AS IDCOUNT FROM CLIENTES');
    });

    test('TestSubstringFirebird', () {
      String result = cqlbr
          .select$()
          .column$('NOME_CLIENTE')
          .substring$(1, 2)
          .as$('NOME')
          .from$('CLIENTES')
          .asResult();

      expect(result,
          'SELECT SUBSTRING(NOME_CLIENTE FROM 1 FOR 2) AS NOME FROM CLIENTES');
    });

    test('TestMonthWhereFirebird', () {
      String result = cqlbr
          .select$()
          .all$()
          .from$('CLIENTES')
          .where$()
          .month$('NASCTO')
          .equal$('9')
          .asResult();

      expect(result,
          'SELECT * FROM CLIENTES WHERE (EXTRACT(MONTH FROM NASCTO) = 9)');
    });

    test('TestMonthSelectFirebird', () {
      String result = cqlbr
          .select$()
          .column$()
          .month$('NASCTO')
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT EXTRACT(MONTH FROM NASCTO) FROM CLIENTES');
    });

    test('TestDayWhereFirebird', () {
      String result = cqlbr
          .select$()
          .all$()
          .from$('CLIENTES')
          .where$()
          .day$('NASCTO')
          .equal$('9')
          .asResult();

      expect(result,
          'SELECT * FROM CLIENTES WHERE (EXTRACT(DAY FROM NASCTO) = 9)');
    });

    test('TestDaySelectFirebird', () {
      String result =
          cqlbr.select$().column$().day$('NASCTO').from$('CLIENTES').asResult();

      expect(result, 'SELECT EXTRACT(DAY FROM NASCTO) FROM CLIENTES');
    });

    test('TestYearWhereFirebird', () {
      String result = cqlbr
          .select$()
          .all$()
          .from$('CLIENTES')
          .where$()
          .year$('NASCTO')
          .equal$('9')
          .asResult();

      expect(result,
          'SELECT * FROM CLIENTES WHERE (EXTRACT(YEAR FROM NASCTO) = 9)');
    });

    test('TestYearSelectFirebird', () {
      String result = cqlbr
          .select$()
          .column$()
          .year$('NASCTO')
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT EXTRACT(YEAR FROM NASCTO) FROM CLIENTES');
    });

    test('TestDateFirebird', () {
      String result = cqlbr
          .select$()
          .all$()
          .from$('CLIENTES')
          .where$()
          .date$('NASCTO')
          .equal$()
          .date$(Fun.q('02/11/2020'))
          .asResult();

      expect(result,
          'SELECT * FROM CLIENTES WHERE NASCTO = ${Fun.q('02/11/2020')}');
    });

    test('TestConcatSelectFirebird', () {
      String result = cqlbr
          .select$()
          .column$()
          .concat$([Fun.q('-'), 'NOME'])
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT ${Fun.q('-')} || NOME FROM CLIENTES');
    });

    test('TestConcatWhereFirebird', () {
      String result = cqlbr
          .select$()
          .column$()
          .concat$([Fun.q('-'), 'NOME'])
          .from$('CLIENTES')
          .where$()
          .concat$([Fun.q('-'), 'NOME'])
          .equal$(Fun.q('-NOME'))
          .asResult();

      expect(result,
          'SELECT ${Fun.q('-')} || NOME FROM CLIENTES WHERE (${Fun.q('-')} || NOME = ${Fun.q('-NOME')})');
    });
  });
}
