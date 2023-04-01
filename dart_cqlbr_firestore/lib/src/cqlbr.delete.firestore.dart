import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:dart_cqlbr_core/dart_cqlbr_core.dart';

class CQLDeleteFirestore extends CQLSection implements ICQLDelete {
  late final FirebaseFirestore instance;
  @protected
  late final ICQLNames _tableNames;

  CQLDeleteFirestore(
    this.instance,
  ) : super(name: 'Delete') {
    _tableNames = CQLNames();
  }

  @override
  T? serialize<T extends Object>() {
    return isEmpty()
        ? null
        : instance.collection(tableNames.serialize<String>()).doc() as T;
  }

  @override
  bool isEmpty() => _tableNames.isEmpty();

  @override
  void clear() {
    _tableNames.clear();
  }

  @override
  ICQLNames get tableNames => _tableNames;
}
