import 'package:bloc_api/data/vos/genere_vo.dart';

abstract class GeneralRepository {
  Future<List<GenereVo>> fetchAllGeneres(String token);
} 