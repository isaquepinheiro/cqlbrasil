import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';
import 'package:dart_cqlbr_firestore/dart_cqlbr_firestore.dart';
import 'package:test/test.dart';

void main() async {
  group('A group of tests -', () {
    // Fake Cloud Firestore
    final instance1 = FakeFirebaseFirestore();

    // CQLBr
    CQLBr cqlbr = CQLBr(select: CQLSelectFirestore(instance1));

    test(
      'Test_Insert_FirebaseFirestore',
      () async {
        final batch = instance1.batch();

        bool result1 = false;
        // CQLBr
        CollectionReference result = cqlbr
            .insert$()
            .into$('users')
            .values$('username', 'Bob 1')
            .values$('email', 'bob1@gmail.com')
            .asResult();
        await result
            .add((cqlbr.ast.insert() as CQLInsertFirestore).toMap())
            .then((value) => result1 = true);

        bool result2 = false;
        // Fake Cloud Firestore
        await instance1
            .collection('users')
            .add({"username": "Bob 2", "email": "bob2@gmail.com"}).then(
                (value) => result2 = true);

        await batch.commit();

        expect(result1, result2);
      },
    );
  });
}
