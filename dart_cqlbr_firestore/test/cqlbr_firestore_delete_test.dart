import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';
import 'package:dart_cqlbr_firestore/dart_cqlbr_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  // Fake Cloud Firestore
  final instance1 = FakeFirebaseFirestore();

  await instance1.collection('users').doc().set(
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
    'Test_Delete_All_FirebaseFirestore',
    () async {
      final batch = instance1.batch();

      bool result1 = false;
      // CQLBr
      DocumentReference result = cqlbr.delete$().from$('users').asResult();
      await result.delete().then((value) => result1 = true).onError(
            (error, stackTrace) => result1 = false,
          );

      bool result2 = false;
      //Fake Cloud Firestore
      await instance1
          .collection('users')
          .doc()
          .delete()
          .then((value) => result2 = true)
          .onError(
            (error, stackTrace) => result2 = false,
          );

      await batch.commit();

      expect(result1, result2);
    },
  );

  test(
    'Test_Delete_Where_FirebaseFirestore',
    () async {
      final batch = instance1.batch();

      bool result1 = false;
      // CQLBr
      Query result = cqlbr
          .delete$()
          .from$('users')
          .where$('email')
          .equal$('bob1@gmail.com')
          .asResult();

      await result.get().then(
        (list) {
          for (var doc in list.docs) {
            doc.reference.delete().then((value) => result1 = true).onError(
                  (error, _) => result1 = false,
                );
          }
        },
      );

      bool result2 = false;
      // Fake Cloud Firestore
      Query resultFake = instance1
          .collection('users')
          .where('email', isEqualTo: 'bob2@gmail.com');

      await resultFake.get().then(
        (list) {
          for (var doc in list.docs) {
            doc.reference.delete().then((value) => result2 = true).onError(
                  (error, _) => result2 = false,
                );
          }
        },
      );

      await batch.commit();

      expect(result1, result2);
    },
  );
}
