import 'package:cqlbr_core/cqlbr_core.dart';
import 'package:cqlbr_mysql/cqlbr_mysql.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests -', () {
    CQLBr cqlbr = CQLBr(select: CQLSelectMySQL());

    test('TestCountMySQL', () {
      String result = cqlbr
          .select$()
          .column$('ID_CLIENTE')
          .count$()
          .as$('IDCOUNT')
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT COUNT(ID_CLIENTE) AS IDCOUNT FROM CLIENTES');
    });

    test('TestLowerMySQL', () {
      String result = cqlbr
          .select$()
          .column$('NOME_CLIENTE')
          .lower$()
          .as$('NOME')
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT LOWER(NOME_CLIENTE) AS NOME FROM CLIENTES');
    });

    test('TestUpperMySQL', () {
      String result = cqlbr
          .select$()
          .column$('NOME_CLIENTE')
          .upper$()
          .as$('NOME')
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT UPPER(NOME_CLIENTE) AS NOME FROM CLIENTES');
    });

    test('TestMaxMySQL', () {
      String result = cqlbr
          .select$()
          .column$('ID_CLIENTE')
          .max$()
          .as$('IDCOUNT')
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT MAX(ID_CLIENTE) AS IDCOUNT FROM CLIENTES');
    });

    test('TestMinMySQL', () {
      String result = cqlbr
          .select$()
          .column$('ID_CLIENTE')
          .min$()
          .as$('IDCOUNT')
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT MIN(ID_CLIENTE) AS IDCOUNT FROM CLIENTES');
    });

    test('TestSubstringMySQL', () {
      String result = cqlbr
          .select$()
          .column$('NOME_CLIENTE')
          .substring$(1, 2)
          .as$('NOME')
          .from$('CLIENTES')
          .asResult();

      expect(
          result, 'SELECT SUBSTRING(NOME_CLIENTE, 1, 2) AS NOME FROM CLIENTES');
    });

    test('TestMonthWhereMySQL', () {
      String result = cqlbr
          .select$()
          .all$()
          .from$('CLIENTES')
          .where$()
          .month$('NASCTO')
          .equal$('9')
          .asResult();

      expect(result, 'SELECT * FROM CLIENTES WHERE (MONTH(NASCTO) = 9)');
    });

    test('TestMonthSelectMySQL', () {
      String result = cqlbr
          .select$()
          .column$()
          .month$('NASCTO')
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT MONTH(NASCTO) FROM CLIENTES');
    });

    test('TestDayWhereMySQL', () {
      String result = cqlbr
          .select$()
          .all$()
          .from$('CLIENTES')
          .where$()
          .day$('NASCTO')
          .equal$('9')
          .asResult();

      expect(result, 'SELECT * FROM CLIENTES WHERE (DAY(NASCTO) = 9)');
    });

    test('TestDaySelectMySQL', () {
      String result =
          cqlbr.select$().column$().day$('NASCTO').from$('CLIENTES').asResult();

      expect(result, 'SELECT DAY(NASCTO) FROM CLIENTES');
    });

    test('TestYearWhereMySQL', () {
      String result = cqlbr
          .select$()
          .all$()
          .from$('CLIENTES')
          .where$()
          .year$('NASCTO')
          .equal$('9')
          .asResult();

      expect(result, 'SELECT * FROM CLIENTES WHERE (YEAR(NASCTO) = 9)');
    });

    test('TestYearSelectMySQL', () {
      String result = cqlbr
          .select$()
          .column$()
          .year$('NASCTO')
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT YEAR(NASCTO) FROM CLIENTES');
    });

    test('TestDateMySQL', () {
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
          'SELECT * FROM CLIENTES WHERE DATE_FORMAT(NASCTO, yyyy-MM-dd) = DATE_FORMAT(\'02/11/2020\', yyyy-MM-dd)');
    });

    test('TestConcatSelectMySQL', () {
      String result = cqlbr
          .select$()
          .column$()
          .concat$([Fun.q('- ||'), 'NOME'])
          .from$('CLIENTES')
          .asResult();

      expect(result, 'SELECT CONCAT(\'- ||\', NOME) FROM CLIENTES');
    });

    test('TestConcatWhereMySQL', () {
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
          'SELECT CONCAT(\'-\', NOME) FROM CLIENTES WHERE (CONCAT(\'-\', NOME) = \'-NOME\')');
    });
  });
}
