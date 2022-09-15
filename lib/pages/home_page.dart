import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:testbloc/pages/searchBloc/search_cep_bloc.dart';
import 'package:testbloc/pages/searchBloc/search_events.dart';
import 'package:testbloc/pages/searchBloc/search_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();
  var searchCepBloc;

  @override
  Widget build(BuildContext context) {
    searchCepBloc = context.read<SearchCepBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar cidade"),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        //alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Digite um Cep",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 14.0, left: 8.0, right: 8.0),
              child: TextFormField(
                controller: textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  labelText: "Cep",
                ),
              ),
            ),
            BlocBuilder<SearchCepBloc, SearchCepState>(
              bloc: searchCepBloc,
              builder: (context, state){
                if(state is SearchCepInitial){
                  return Container();
                }
                if(state is SearchCepError){
                  return Padding(
                  padding: const EdgeInsets.only(top: 0.0, bottom: 8.0, left: 4.0, right: 4.0),
                  child: SizedBox(
                    height: 65,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 0,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        )
                      ),
                        child: const Center(
                            child: Text("Ocorreu um erro na requisição",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                        )
                    ),
                  ),
                );
                }
                if(state is SearchCepLoading){
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                // Isso aqui faz com que o state seja um SearchCepSucess, o "as" faz isso
                state = state as SearchCepSucess;
                return Padding(
                  padding: const EdgeInsets.only(top: 0.0, bottom: 8.0, left: 4.0, right: 4.0),
                  child: SizedBox(
                    height: 65,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 0,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        )
                      ),
                        child: Center(
                            child: Text("Cidade: ${state.data["localidade"]}-${state.data["uf"]}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                        )
                    ),
                  ),
                );
              },
            ),
            Center(
              child: ElevatedButton(
                child: Text("Pesquisar"),
                onPressed: (){
                  //searchCepBloc.add(textController.text);
                  context.read<SearchCepBloc>().add(SearchingCepEvent(cep: textController.text));
                },
              ),
            ),
            // BlocBuilder recebe como tipagem o bloc e o state dele
          ],
        ),
      ),
    );
  }
}
