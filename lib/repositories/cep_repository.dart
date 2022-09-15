import 'package:dio/dio.dart';

class CepRepository{
  final dio = Dio();

  Future<dynamic> getMapCep(String cep) async{
    final response = await Dio().get("https://viacep.com.br/ws/$cep/json/");
    if(response.statusCode == 200){
      return response.data;
    }else{
      return null;
    }
  }
}