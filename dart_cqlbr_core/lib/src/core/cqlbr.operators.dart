import '../interface/cqlbr.interface.dart';
import 'cqlbr.utils.dart';

class CQLOperator implements ICQLOperator {
  final CQLDatabase? database;
  late final CQLDataFieldType _dataType;
  late CQLOperatorCompare _compare;
  late String _columnName;
  late dynamic _value;

  CQLOperator({this.database, dynamic value}) {
    _value = value;
    _compare = CQLOperatorCompare.fcNone;
  }

  @override
  String get columnName => _columnName;
  @override
  set columnName(String value) => _columnName = value;

  @override
  CQLOperatorCompare get compare => _compare;
  @override
  set compare(CQLOperatorCompare value) => _compare = value;

  @override
  CQLDataFieldType get dataType => _dataType;
  @override
  set dataType(CQLDataFieldType value) => _dataType = value;

  @override
  dynamic get value => _value;
  @override
  set value(dynamic value) {
    _value = _getCompareValue(value);
  }

  String _getCompareValue(dynamic value) {
    if (value == null) {
      return 'NULL';
    }

    String result = '';
    switch (_dataType) {
      case CQLDataFieldType.dftString:
        result = value.toString();
        switch (_compare) {
          case CQLOperatorCompare.fcLike:
            result = Utils.instance.concat(['\'', result, '\''], delimiter: '');
            break;
          case CQLOperatorCompare.fcNotLike:
            result = Utils.instance.concat(['\'', result, '\''], delimiter: '');
            break;
          case CQLOperatorCompare.fcLikeFull:
            result =
                Utils.instance.concat(['\'%', result, '%\''], delimiter: '');
            break;
          case CQLOperatorCompare.fcNotLikeFull:
            result =
                Utils.instance.concat(['\'%', result, '%\''], delimiter: '');
            break;
          case CQLOperatorCompare.fcLikeLeft:
            result = Utils.instance.concat(['\'%', result], delimiter: '');
            break;
          case CQLOperatorCompare.fcNotLikeLeft:
            result = Utils.instance.concat(['\'%', result], delimiter: '');
            break;
          case CQLOperatorCompare.fcLikeRight:
            result =
                Utils.instance.concat(['\'', result, '%\''], delimiter: '');
            break;
          case CQLOperatorCompare.fcNotLikeRight:
            result =
                Utils.instance.concat(['\'', result, '%\''], delimiter: '');
            break;
          default:
        }
        break;
      case CQLDataFieldType.dftInteger:
        result = value.toString();
        break;
      case CQLDataFieldType.dftFloat:
        result = value.toString().replaceAll(',', '.');
        break;
      case CQLDataFieldType.dftDate:
        result = '\'${Utils.instance.dateToSQLFormat(database!, value)}\'';
        break;
      case CQLDataFieldType.dftDateTime:
        result = '\'${Utils.instance.dateTimeToSQLFormat(database!, value)}\'';
        break;
      case CQLDataFieldType.dftGuid:
        result = Utils.instance.guidStrToSQLFormat(database!, value.toString());
        break;
      case CQLDataFieldType.dftArray:
        result = _arrayValueToString(value);
        break;
      case CQLDataFieldType.dftBoolean:
        result = value.toString();
        break;
      case CQLDataFieldType.dftText:
        result = '($value)';
        break;
      default:
    }

    return result;
  }

  String _arrayValueToString(dynamic values) {
    final List<dynamic> list = [...values as List<dynamic>];
    String result = '(';
    dynamic value = '';

    for (int i = 0; i < list.length; i++) {
      value = list[i];
      result += i == 0 ? '' : ', ';
      result += value.runtimeType.toString() == 'String'
          ? '\'$value\''
          : value.toString().replaceAll(',', '.');
    }
    result += ')';

    return result;
  }
}

class CQLOperators implements ICQLOperators {
  final CQLDatabase database;

  CQLOperators({
    required this.database,
  });

  ICQLOperator _createOperator(
    String columnName,
    dynamic value,
    CQLOperatorCompare compare,
  ) {
    final CQLOperator result = CQLOperator(
      database: database,
    );
    result.dataType = compare == CQLOperatorCompare.fcIn ||
            compare == CQLOperatorCompare.fcNotIn ||
            compare == CQLOperatorCompare.fcExists ||
            compare == CQLOperatorCompare.fcNotExists
        ? CQLDataFieldType.dftText
        : _resolveDataFieldType(value);
    result.columnName = columnName;
    result.compare = compare;
    result.value = value;

    return result;
  }

  CQLDataFieldType _resolveDataFieldType(dynamic value) {
    switch (value.runtimeType.toString()) {
      case 'String':
        return CQLDataFieldType.dftString;
      case 'int':
        return CQLDataFieldType.dftInteger;
      case '() => DateTime':
        return CQLDataFieldType.dftDateTime;
      case 'JSArray<dynamic>':
        return CQLDataFieldType.dftArray;
      case 'bool':
        return CQLDataFieldType.dftBoolean;
      case 'Null':
        return CQLDataFieldType.dftUnknown;
      default:
        return CQLDataFieldType.dftUnknown;
    }
  }

  @override
  ICQLOperator isEqual(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcEqual);
  }

  @override
  ICQLOperator isExists(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcExists);
  }

  @override
  ICQLOperator isGreaterEqThan(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcGreaterEqual);
  }

  @override
  ICQLOperator isGreaterThan(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcGreater);
  }

  @override
  ICQLOperator isIn(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcIn);
  }

  @override
  ICQLOperator isLessEqThan(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcLessEqual);
  }

  @override
  ICQLOperator isLessThan(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcLess);
  }

  @override
  ICQLOperator isLike(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcLike);
  }

  @override
  ICQLOperator isLikeFull(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcLikeFull);
  }

  @override
  ICQLOperator isLikeLeft(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcLikeLeft);
  }

  @override
  ICQLOperator isLikeRight(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcLikeRight);
  }

  @override
  ICQLOperator isNotEqual(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcNotEqual);
  }

  @override
  ICQLOperator isNotExists(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcNotExists);
  }

  @override
  ICQLOperator isNotIn(dynamic value) {
    return _createOperator('', value, CQLOperatorCompare.fcNotIn);
  }

  @override
  ICQLOperator isNotLike(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcNotLike);
  }

  @override
  ICQLOperator isNotLikeFull(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcNotLikeFull);
  }

  @override
  ICQLOperator isNotLikeLeft(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcNotLikeLeft);
  }

  @override
  ICQLOperator isNotLikeRight(String value) {
    return _createOperator('', value, CQLOperatorCompare.fcNotLikeRight);
  }

  @override
  ICQLOperator isNotNull() {
    return _createOperator('', null, CQLOperatorCompare.fcIsNotNull);
  }

  @override
  ICQLOperator isNull() {
    return _createOperator('', null, CQLOperatorCompare.fcIsNull);
  }
}
