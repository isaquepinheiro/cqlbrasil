import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';
import 'package:flutter_cqlbr_mongodb/src/cqlbr.select.mongodb.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  CQLBr cqlbr = CQLBr(select: CQLSelectMongoDB());

  test('SelectMongoDB', () {
    String result = cqlbr
        .select$()
        .column$('id')
        .column$('user_id')
        .column$('status')
        .from$('people')
        .asString();
    expect(result, '{nome: "Isaque", sobrenome: "Pinheiro", idade: 51}');
  });

  test('InsertMongoDB', () {
    String result = cqlbr
        .insert$()
        .into$('customers')
        .set$('nome', 'Isaque')
        .set$('sobrenome', 'Pinheiro')
        .set$('idade', 51)
        .asString();
    expect(result, '{nome: "Isaque", sobrenome: "Pinheiro", idade: 51}');
  });
}
