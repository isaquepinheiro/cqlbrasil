import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';
import 'package:dart_cqlbr_mongodb/dart_cqlbr_mongodb.dart';
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
        .asResult();
    expect(result, 'people.find({}, { id: 1, user_id: 1, status: 1 })');
  });

  test('SelectMongoDB', () {
    String result = cqlbr
        .select$()
        .from$('people')
        .asResult();
    expect(result, 'people.find({})');
  });

  test('InsertMongoDB', () {
    String result = cqlbr
        .insert$()
        .into$('customers')
        .set$('nome', 'Isaque')
        .set$('sobrenome', 'Pinheiro')
        .set$('idade', 51)
        .asResult();
    expect(result, 'customers.insertOne({ nome: "Isaque", sobrenome: "Pinheiro", idade: 51 })');
  });
}