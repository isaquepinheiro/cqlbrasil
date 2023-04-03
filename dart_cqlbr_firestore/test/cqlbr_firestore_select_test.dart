import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';
import 'package:dart_cqlbr_firestore/dart_cqlbr_firestore.dart';
import 'package:test/test.dart';

class Person {
  String username;
  String sobrenome;
  String email;

  Person(
      {required this.username, required this.sobrenome, required this.email});
}

void main() async {
  // Fake Cloud Firestore
  group('A group of tests -', () {
    final instance1 = FakeFirebaseFirestore();

    instance1.collection('users').doc('1').set(
      {
        'username': 'Bob 1',
        'sobrenome': 'Sobrenome Bob 1',
        'email': 'bob1@gmail.com',
      },
    );

    instance1.collection('users').doc('2').set(
      {
        'username': 'Bob 2',
        'sobrenome': 'Sobrenome Bob 2',
        'email': 'bob2@gmail.com',
      },
    );
    // CQLBr
    CQLBr cqlbr = CQLBr(select: CQLSelectFirestore(instance1));

    // Antes de cada test
    setUp(() {});

    // Depois de cada test
    tearDown(() {});

    test(
      'Test_Select_FirebaseFirestore',
      () async {
        final batch = instance1.batch();

        // CQLBr
        Query result1 = cqlbr.select$().all$().from$('users').asResult();
        QuerySnapshot snapshot1 = await result1.get();

        // Fake Cloud Firestore
        QuerySnapshot snapshot2 = await instance1.collection('users').get();

        await batch.commit();

        debugPrint('snapshot1=>${snapshot1.docs.length.toString()}');
        debugPrint('snapshot2=>${snapshot2.docs.length.toString()}');

        expect(snapshot1.docs.length, equals(snapshot2.docs.length) );
      },
    );

    test(
      'Test_Select_Where_FirebaseFirestore',
      () async {
        final batch = instance1.batch();

        // CQLBr
        Query result1 = cqlbr
            .select$()
            .all$()
            .from$('users')
            .where$('username')
            .equal$('Bob 1')
            .and$('email')
            .equal$('bob1@gmail.com')
            .or$('sobrenome')
            .equal$('Sobrenome Bob 1')
            .orderBy$('username, sobrenome')
            .desc$()
            .pageSize(1)
            .pagePosition(0)
            .asResult();

        late QuerySnapshot snapshot1;
        late List<Person> results = [];

        await result1.get().then((QuerySnapshot snapshot) {
          snapshot1 = snapshot;
          for (var doc in snapshot.docs) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            Person result = Person(
                username: data["username"],
                sobrenome: data["sobrenome"],
                email: data["email"]);
            results.add(result);
          }
        }).catchError((error) {
          debugPrint("Ocorreu um erro ao obter o QuerySnapshot: $error");
        });

        // Fake Cloud Firestore
        Query result2 = instance1
            .collection('users')
            .where('username', isEqualTo: 'Bob 1')
            .where('email', isEqualTo: 'bob1@gmail.com')
            .where('sobrenome', isEqualTo: 'Sobrenome Bob 1')
            .orderBy('username, sobrenome', descending: true)
            .limit(1);
        QuerySnapshot snapshot2 = await result2.get();

        await batch.commit();

        debugPrint('snapshot1=>${snapshot1.docs.length.toString()}');
        debugPrint('snapshot2=>${snapshot2.docs.length.toString()}');

        expect(snapshot1.docs.length, equals(snapshot2.docs.length));
      },
    );
  });
}
