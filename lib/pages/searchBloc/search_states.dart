// É o estado global, os outros estados vão implementar essa interface, ou seja, os outros estados vão ser SearchCepState
// É como se toda class que implementar SearchCepState, também vai ser SearchCepState
abstract class SearchCepState{}

// Estados da aplicação (Estado de sucesso, de loading e de erro)
class SearchCepSucess implements SearchCepState{
  final Map data;

  SearchCepSucess({required this.data});
}

class SearchCepInitial implements SearchCepState{
  SearchCepInitial();
}

class SearchCepLoading implements SearchCepState{
  SearchCepLoading();
}

class SearchCepError implements SearchCepState{
  final String errorMessage;

  SearchCepError(this.errorMessage);
}