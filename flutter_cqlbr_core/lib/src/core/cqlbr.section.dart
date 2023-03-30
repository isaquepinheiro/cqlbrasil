import '../interface/cqlbr.interface.dart';

class CQLSection implements ICQLSection {
  late String _name;

  CQLSection({
    required String name,
  }) {
    _name = name;
  }

  @override
  void clear() {
    _name = '';
  }

  @override
  bool isEmpty() {
    return _name.isEmpty;
  }

  @override
  String get name => _name;
}
