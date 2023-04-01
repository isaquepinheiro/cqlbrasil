## Criteria Query Language Brasil (Dart/Flutter)

CQLBr é um framework opensource que provê escritas gerando o script SQL, através de uma interface, permitindo mapear de forma orientada a objeto, toda sintaxe de comandos SQL (SELECT, INSERT, UPDATE e DELETE), para banco de dados relacional.

Durante o desenvolvimento de software, é evidente a preocupação em que se tem em aumentar a produtividade e manter a compatibilidade entre os possíveis bancos que um sistema pode usar. No que se refere a sintaxe de banco de dados, temos em alguns casos, incompatibilidades entre comandos SQL, exigindo assim, a necessidade de um maior controle na escrita de cada banco, e foi para ajudar nesse ponto crítico que CQLBr nasceu, ele foi projetado para que a escrita de querys seja única, de forma funcional e orientada a objeto, possibilitando assim a mesma escrita feita pelo framework, gerar querys diferentes conforme o banco selecionado, o qual pode ser mudado de forma muito simples, bastando selecionar um dos modelos implementados no CQLBr Framework, sem ter que re-faturar diversas querys espalhadas pelas milhares de linhas de código.

## Flutter CQLBr Firestore

<img src="https://www.isaquepinheiro.com.br/projetos/cqlbr-framework-for-delphilazarus-65199.png" width="1280" height="500">

## COMO COMEÇAR A USAR

```dart
  CQLBr cqlbr = CQLBr(select: CQLSelectFirebird(FirebaseFirestore.instance));
```

## Dependência

- [CQLBr Framework for Dart/Flutter (Core)](https://github.com/isaquepinheiro/flutter_cqlbr_core)

TODO: Ao instâncias o CQL, deve-se injetar a ele o modelo do banco que se vai usar, isso poderá ser feito pode parâmetro em seu sistema, configurando qual modelo será injetado.

## SELECT

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';
import 'package:flutter_cqlbr_firestore/flutter_cqlbr_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  // Fake Cloud Firestore
  final instance1 = FakeFirebaseFirestore();

  await instance1.collection('users').doc('1').set(
    {
      'username': 'Bob 1',
      'sobrenome': 'Sobrenome Bob 1',
      'email': 'bob1@gmail.com',
    },
  );

  await instance1.collection('users').doc('2').set(
    {
      'username': 'Bob 2',
      'sobrenome': 'Sobrenome Bob 2',
      'email': 'bob2@gmail.com',
    },
  );


  // CQLBr
  CQLBr cqlbr = CQLBr(select: CQLSelectFirestore(instance1));

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

      expect(snapshot1.docs.length, snapshot2.docs.length);
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
          .orderBy$('username, sobrenome').desc$()
          .asResult();
      QuerySnapshot snapshot1 = await result1.get();

      // Fake Cloud Firestore
      Query result2 = instance1
          .collection('users')
          .where('username', isEqualTo: 'Bob 1')
          .where('email', isEqualTo: 'bob1@gmail.com')
          .where('sobrenome', isEqualTo: 'Sobrenome Bob 1')
          .orderBy('username, sobrenome', descending: true);
      QuerySnapshot snapshot2 = await result2.get();

      await batch.commit();

      debugPrint('snapshot1=>${snapshot1.docs.length.toString()}');
      debugPrint('snapshot2=>${snapshot2.docs.length.toString()}');

      expect(snapshot1.docs.length, snapshot2.docs.length);
    },
  );
}
```

## INSERT

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';
import 'package:flutter_cqlbr_firestore/flutter_cqlbr_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
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
}
```

## UPDATE

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';
import 'package:flutter_cqlbr_firestore/flutter_cqlbr_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

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
```

## DELETE

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_cqlbr_core/flutter_cqlbr_core.dart';
import 'package:flutter_cqlbr_firestore/flutter_cqlbr_firestore.dart';
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
```

## Additional information

TODO: multi-database SQL syntax using object orientation, now in flutter.
