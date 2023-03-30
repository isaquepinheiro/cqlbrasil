import '../interface/cqlbr.interface.dart';

class Utils {
  static Utils? _instance;

  Utils._();

  static Utils get instance => _instance ??= Utils._();

  String concat(List<dynamic> elements, {String delimiter = ' '}) {
    String result = '';

    for (final dynamic value in elements) {
      if (value.toString().isNotEmpty) {
        result = _addToList(result, delimiter, value);
      }
    }

    return result;
  }

  String sqlParamsToStr(List<dynamic> params) {
    String result = '';
    String param = '';
    String lastch = '';

    for (int i = 0; i < params.length; i++) {
      param = params[i].toString();
      if (result == '') {
        lastch = ' ';
      } else {
        lastch = result[result.length];
      }
      if (lastch != '.' &&
          lastch != '(' &&
          lastch != ' ' &&
          lastch != ':' &&
          param != ',' &&
          param != '.' &&
          param != ')') {
        result += ' ';
      }
      result += param;
    }

    return result;
  }

  String dateToSQLFormat(CQLDatabase database, DateTime date) {
    switch (database) {
      case CQLDatabase.dbnADs:
        return '${date.year}-${date.month}-${date.day}';
      case CQLDatabase.dbnASA:
        return '${date.year}-${date.month}-${date.day}';
      case CQLDatabase.dbnDB2:
        return '${date.year}-${date.month}-${date.day}';
      case CQLDatabase.dbnFirestore:
        return '${date.year}-${date.month}-${date.day}';
      case CQLDatabase.dbnFirebird:
        return '${date.year}-${date.month}-${date.day}';
      case CQLDatabase.dbnInformix:
        return '${date.year}-${date.month}-${date.day}';
      case CQLDatabase.dbnInterbase:
        return '${date.month}/${date.year}/${date.day}';
      case CQLDatabase.dbnMongoDB:
        return '${date.year}-${date.month}-${date.day}';
      case CQLDatabase.dbnMySQL:
        return '${date.year}-${date.month}-${date.day}';
      case CQLDatabase.dbnNexusDB:
        return '${date.year}-${date.month}-${date.day}';
      case CQLDatabase.dbnOracle:
        return '${date.year}-${date.month}-${date.day}';
      case CQLDatabase.dbnPostgreSQL:
        return '${date.year}-${date.month}-${date.day}';
      case CQLDatabase.dbnSQLServer:
        return '${date.year}-${date.month}-${date.day}';
      case CQLDatabase.dbnSQLite:
        return '${date.year}-${date.month}-${date.day}';
      default:
        return '${date.year}-${date.month}-${date.day}';
    }
  }

  String dateTimeToSQLFormat(CQLDatabase database, DateTime date) {
    switch (database) {
      case CQLDatabase.dbnADs:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case CQLDatabase.dbnASA:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case CQLDatabase.dbnDB2:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case CQLDatabase.dbnFirestore:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case CQLDatabase.dbnFirebird:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case CQLDatabase.dbnInformix:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case CQLDatabase.dbnInterbase:
        return '${date.month}/${date.year}/${date.day} ${date.hour}:${date.minute}:${date.second}';
      case CQLDatabase.dbnMongoDB:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case CQLDatabase.dbnMySQL:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case CQLDatabase.dbnNexusDB:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case CQLDatabase.dbnOracle:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case CQLDatabase.dbnPostgreSQL:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case CQLDatabase.dbnSQLServer:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      case CQLDatabase.dbnSQLite:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
      default:
        return '${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}:${date.second}';
    }
  }

  String guidStrToSQLFormat(CQLDatabase database, String guid) {
    switch (database) {
      case CQLDatabase.dbnADs:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case CQLDatabase.dbnASA:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case CQLDatabase.dbnDB2:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case CQLDatabase.dbnFirestore:
        return 'CHAR_TO_UUID(' '$guid' ')';
      case CQLDatabase.dbnFirebird:
        return 'CHAR_TO_UUID(' '$guid' ')';
      case CQLDatabase.dbnInformix:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case CQLDatabase.dbnInterbase:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case CQLDatabase.dbnMongoDB:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case CQLDatabase.dbnMySQL:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case CQLDatabase.dbnNexusDB:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case CQLDatabase.dbnOracle:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case CQLDatabase.dbnPostgreSQL:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case CQLDatabase.dbnSQLServer:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      case CQLDatabase.dbnSQLite:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
      default:
        return '${guid.substring(0, 8)}-${guid.substring(8, 12)}-${guid.substring(12, 16)}-${guid.substring(16, 20)}-${guid.substring(20, 32)}';
    }
  }

  String _addToList(String list, String delimiter, dynamic element) {
    String result = list;

    if (result.isNotEmpty) {
      result += delimiter;
    }
    result += element.toString();

    return result;
  }
}
