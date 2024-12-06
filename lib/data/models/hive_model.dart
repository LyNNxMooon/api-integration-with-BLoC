import 'package:bloc_api/persistent/hive_dao.dart';

class HiveModel {
  HiveModel._();
  static final HiveModel _singleton = HiveModel._();
  factory HiveModel() => _singleton;

  final HiveDao _hiveDao = HiveDao();

  void saveUserToken(String token) => _hiveDao.saveUserToken(token);

  String getUserToken() => _hiveDao.getUserToken() ?? "";
}
