import 'package:dio/dio.dart';

class AuthServices {
  AuthServices(this.dio);

  final Dio dio;

  Future<dynamic> getPokemonList(int offset) async {
    final Response response = await dio.get(
      'v2/pokemon?limit=10&offset=$offset',
    );
    return response.data;
  }

  Future<dynamic> search(String name) async {
    final Response response = await dio.get('v2/pokemon/$name');
    return response.data;
  }
}
