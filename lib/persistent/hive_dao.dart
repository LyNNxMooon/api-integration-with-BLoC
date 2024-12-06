import 'package:bloc_api/domain/persistent_repository.dart';
import 'package:bloc_api/persistent/hive_constant.dart';

import 'package:hive_flutter/hive_flutter.dart';

class HiveDao implements PersistentRepo {
  HiveDao._();
  static final HiveDao _singleton = HiveDao._();
  factory HiveDao() => _singleton;

  Box<String> getUserTokenBox() => Hive.box<String>(kBoxNameForUserToken);

  @override
  String? getUserToken() => getUserTokenBox().get(kHiveKeyForUserToken);

  @override
  saveUserToken(String token) =>
      getUserTokenBox().put(kHiveKeyForUserToken, token);
}
