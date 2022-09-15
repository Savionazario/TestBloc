import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testbloc/pages/searchBloc/search_events.dart';
import 'package:testbloc/pages/searchBloc/search_states.dart';
import 'package:provider/provider.dart';
import 'package:testbloc/repositories/cep_repository.dart';
//import 'package:http/http.dart' as http;

// Para utilizar o package flutter_bloc, temos que extender Bloc<Entrada/evento, Saída/state>
class SearchCepBloc extends Bloc<SearchCepEvent, SearchCepState>{
  //SearchCepBloc(super.initialState);
  final CepRepository cepRepository;

  // Passando um map vazio( {} ) para o dado inicial
  SearchCepBloc(this.cepRepository) : super(SearchCepInitial()){
    //on<String>((event, emit) => mapEventToState(event.toString()));

    on<LoadSearchCepEvent>(
      (event, emit) => emit(SearchCepLoading())
    );

    on<SearchingCepEvent>(
      (event, emit) async{
        emit(SearchCepLoading());
        try{
          //final response = await Dio().get("https://viacep.com.br/ws/${event.cep}/json/");
          var response = await cepRepository.getMapCep(event.cep);
          emit(SearchCepSucess(data: response));

        }catch (e){
          emit(SearchCepError("Ocorreu um erro na requisição"));
        }
      }
    );

    // on<ErrorSearchCepEvent>(
    //   (event, emit) => emit(SearchCepError("Ocorreu um erro"))
    // );
  }

  // O retorno da Função tem que ser uma Stream de algo tipo, nesse caso é do tipo SearchCepState
  // O async* serve para poder retornar streams, ou seja, podemos retornar vários retornos com o operador "yield"
  // Stream<SearchCepState> mapEventToState(String cep) async*{
  //   yield SearchCepLoading();
  //   try{
  //     final response = await Dio().get("https://viacep.com.br/ws/$cep/json/");
  //     //final response = await http.get(Uri.parse("https://viacep.com.br/ws/$cep/json/"));
  //     yield SearchCepSucess(response.data);
  //   }catch (e){
  //     yield SearchCepError("Um Erro Ocorreu");
  //   }
  // }

}