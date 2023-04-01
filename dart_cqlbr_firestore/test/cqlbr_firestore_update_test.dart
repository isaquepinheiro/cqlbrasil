import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';
import 'package:dart_cqlbr_firestore/dart_cqlbr_firestore.dart';
import 'package:test/test.dart';

void main() async {
  // Fake Cloud Firestore
  final instance1 = FakeFirebaseFirestore();

  await instance1.collection('users').doc('1').set(
    {
      'username': 'Bob 1',
      'email': 'bob1@gmail.com',
    },
  );

  await instance1.collection('users').doc('2').set(
    {
      'username': 'Bob 2',
      'email': 'bob2@gmail.com',
    },
  );

  // CQLBr
  CQLBr cqlbr = CQLBr(select: CQLSelectFirestore(instance1));

  test(
    'Test_Update_Where_FirebaseFirestore',
    () async {
      // Vários testes de operações no banco de dados,
      // devem estar cobertos por uma trasação.
      final batch = instance1.batch();

      bool result1 = false;
      // CQLBr
      Query result = cqlbr
          .update$('users')
          .set$('username', 'Bob de Esponja')
          .where$('email')
          .equal$('bob1@gmail.com')
          .asResult();
      await result.get().then(
        (list) {
          for (var doc in list.docs) {
            doc.reference
                .update((cqlbr.ast.update() as CQLUpdateFirestore).toMap())
                .then((value) => result1 = true)
                .onError((error, stackTrace) => result1 = false);
          }
        },
      );

      bool result2 = false;
      // Fake Cloud Firestore
      await instance1
          .collection('users')
          .where('email', isEqualTo: 'bob2@gmail.com')
          .get()
          .then(
        (list) {
          for (var doc in list.docs) {
            doc.reference
                .update({'username': 'Bob Esponjas'})
                .then((value) => result2 = true)
                .onError((error, stackTrace) => result2 = false);
          }
        },
      );

      await batch.commit();

      expect(result1, result2);
    },
  );
}
