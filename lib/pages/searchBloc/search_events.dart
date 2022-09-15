abstract class SearchCepEvent{

}

class LoadSearchCepEvent extends SearchCepEvent{

}

class SearchingCepEvent extends SearchCepEvent{
  String cep;

  SearchingCepEvent({required this.cep});
}

// class ErrorSearchCepEvent extends SearchCepEvent{
//
// }