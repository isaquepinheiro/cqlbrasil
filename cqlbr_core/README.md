## Criteria Query Language Brasil (Dart/Flutter)

CQLBr é um framework opensource que provê escritas gerando o script SQL, através de uma interface, permitindo mapear de forma orientada a objeto, toda sintaxe de comandos SQL (SELECT, INSERT, UPDATE e DELETE), para banco de dados relacional.

Durante o desenvolvimento de software, é evidente a preocupação em que se tem em aumentar a produtividade e manter a compatibilidade entre os possíveis bancos que um sistema pode usar. No que se refere a sintaxe de banco de dados, temos em alguns casos, incompatibilidades entre comandos SQL, exigindo assim, a necessidade de um maior controle na escrita de cada banco, e foi para ajudar nesse ponto crítico que CQLBr nasceu, ele foi projetado para que a escrita de querys seja única, de forma funcional e orientada a objeto, possibilitando assim a mesma escrita feita pelo framework, gerar querys diferentes conforme o banco selecionado, o qual pode ser mudado de forma muito simples, bastando selecionar um dos modelos implementados no CQLBr Framework, sem ter que re-faturar diversas querys espalhadas pelas milhares de linhas de código.

## Flutter CQLBr Core

<img src="https://www.isaquepinheiro.com.br/projetos/cqlbr-framework-for-delphilazarus-65199.png" width="1280" height="500">

## Dependência para:

- [CQLBr Framework for Dart/Flutter (Firebird)](https://github.com/isaquepinheiro/flutter_cqlbr_firebird)
- [CQLBr Framework for Dart/Flutter (Firestore)](https://github.com/isaquepinheiro/flutter_cqlbr_firestore)
- [CQLBr Framework for Dart/Flutter (SQLite)](https://github.com/isaquepinheiro/flutter_cqlbr_sqlite)


TODO: Ao instâncias o CQL, deve-se injetar a ele o modelo do banco que se vai usar, isso poderá ser feito por parâmetro em seu sistema, configurando qual modelo será injetado.

## SELECT

```dart
  Expect : "SELECT ID_CLIENTE, NOME_CLIENTE, (CASE TIPO_CLIENTE WHEN 0 THEN 'FISICA' WHEN 1 THEN 'JURIDICA' ELSE 'PRODUTOR' END) AS TIPO_PESSOA FROM CLIENTES");

  String result = cqlbr
        .select$()
          .column$('ID_CLIENTE')
          .column$('NOME_CLIENTE')
          .column$('TIPO_CLIENTE')
          .case$(null)
            .when$('0').then$(Fun.q('FISICA'))
            .when$('1').then$(Fun.q('JURIDICA'))
                       .else$(Fun.q('PRODUTOR'))
          .end$()
        .as$('TIPO_PESSOA')
        .from$('CLIENTES')
    .asString();
```

## INSERT

```dart
Expect : "INSERT INTO CLIENTES (ID_CLIENTE, NOME_CLIENTE) VALUES (1, 'MyName')";

String result = cqlbr
       .insert$()
       .into$('CLIENTES')
       .set$('ID_CLEINTE', 1)
       .set$('NOME_CLIENTE', 'MyName')
    .asString();
```

## UPDATE

```dart
Expect : "UPDATE CLIENTES SET ID_CLIENTE = 2, NOME_CLIENTE = 'MyName' WHERE ID_CLIENTE = 1";

String result = cqlbr
       .update$()
       .set$('ID_CLEINTE', 2)
       .set$('NOME_CLIENTE', 'MyName')
       .where$('ID_CLIENTE = 1')
    .asString();
```

## DELETE

```dart
Expect : "DELETE FROM CLIENTES WHERE ID_CLIENTE = 1";

String result = cqlbr
       .delete$()
       .from$('CLIENTES') 
       .where$('ID_CLIENTE = 1')
    .asString();
```

## Additional information

TODO: multi-database SQL syntax using object orientation, now in flutter.