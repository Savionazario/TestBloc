import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:testbloc/pages/home_page.dart';
import 'package:testbloc/pages/searchBloc/search_cep_bloc.dart';
import 'package:testbloc/repositories/cep_repository.dart';

void main() {
  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //final cepRepository = CepRepository();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CepRepository()),
        BlocProvider(create: (context) => SearchCepBloc(context.read<CepRepository>())),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}