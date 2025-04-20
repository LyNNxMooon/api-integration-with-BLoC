import 'package:bloc_api/data/vos/genere_vo.dart';

abstract class GenereStates {}

class GenereInit extends GenereStates {}

class GenereLoading extends GenereStates {}

class GenereLoaded extends GenereStates {
  final List<GenereVo> generes;

  GenereLoaded({required this.generes});
}

class GenereError extends GenereStates {
  final String message;

  GenereError({required this.message});
}
