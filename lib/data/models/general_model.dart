import 'package:bloc_api/data/vos/genere_vo.dart';
import 'package:bloc_api/domain/general_repository.dart';
import 'package:bloc_api/network/data_agent/data_agent.dart';
import 'package:bloc_api/network/data_agent/data_agent_impl.dart';

class GeneralModel implements GeneralRepository {
  GeneralModel._();
  static final GeneralModel _singleton = GeneralModel._();
  factory GeneralModel() => _singleton;

  final DataAgent _dataAgent = DataAgentImpl();

  @override
  Future<List<GenereVo>> fetchAllGeneres(String token) async {
    try {
      return await _dataAgent.getAllGeneres(token);
    } on Exception catch (error) {
      return Future.error(error);
    }
  }
}
